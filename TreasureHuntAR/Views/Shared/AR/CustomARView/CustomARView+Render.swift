//
//  CustomARView+Render.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import Foundation
import RealityKit
import ARKit
import SwiftUI
import Combine



extension CustomARView {
    
    func addTextToParchment(text: String){
        
        if let presenter = viewPresenter as? CreateViewPresenter {
            let parchmentEntity = presenter.objectToAdd as! ParchmentEntity
            
            
            let mesh = MeshResource.generateText(
                text,
                extrusionDepth: 0.0001,
                font: .systemFont(ofSize: 0.018),
                containerFrame: CGRect(x: 0, y: 0, width: 0.3, height: 0.3),
                alignment: .left,
                lineBreakMode: .byWordWrapping)
                
            let sm = UnlitMaterial(color: UIColor.white)
            let textEntity = ModelEntity(mesh: mesh, materials: [sm])
            
            var modelEntity: CustomModelEntity
            
            if(presenter.parchmentToModify == nil) {
                modelEntity = (presenter.objectToAdd?.modelEntity!)! as CustomModelEntity
            } else {
                modelEntity = presenter.parchmentToModify!
            }
            
            
            let screenScale = UIScreen.main.scale
            
            let xWidth = Float(
                Float(parchmentEntity.width) * Float(parchmentEntity.offset.x * screenScale * 0.0002645833))
            let yWidth =  Float(250*screenScale*0.0002645833)
            
            let xHeight = Float(
                Float(parchmentEntity.height) * Float(parchmentEntity.offset.y * screenScale * 0.0002645833))
            let yHeight = Float(280*screenScale*0.0002645833)
            
            modelEntity.objectEntity = parchmentEntity
            modelEntity.parchmentText = text
            
            textEntity.name = "parchmentText"
            modelEntity.addChild(textEntity)
            textEntity.setPosition(SIMD3<Float>(-presenter.objectToAdd!.width/2 + xWidth/yWidth, -presenter.objectToAdd!.height/2 - xHeight/yHeight, 0.001), relativeTo: modelEntity)
            
            self.sessionModelEntities = self.sessionModelEntities.map({if (parchmentEntity.identifier == $0.identifier) {$0.text = text;$0.textPosition = textEntity.position}; return $0})
            
            self.scene.addAnchor(modelEntity.anchor!)
        }
    }
    
    
    
    func addAnchorEntityToScene(anchor: ARAnchor)  {
        
        if let presenter = viewPresenter as? CreateViewPresenter {
            
            guard anchor.name != nil else {
                return
            }
           
            if(anchor.name!.hasPrefix(Utils.parchmentPrefix.rawValue)) {
                virtualObjectAnchor = anchor
                
                
                if let modelEntity = presenter.objectToAdd?.modelEntity {
                    print("DEBUG: adding model to scene -")
                    
                    modelEntity.generateCollisionShapes(recursive: true)
                   
                    
                    self.installGestures([.rotation, .scale], for: modelEntity).forEach { entityGesture in
                            entityGesture.addTarget(self, action: #selector(handleEntityGesture(_:)))
                        }
                 
                    // Add modelEntity and anchorEntity into the scene for rendering
                    let anchorEntity = AnchorEntity(anchor: anchor)
                    modelEntity.type = .none
                    modelEntity.identifier = presenter.objectToAdd!.identifier
                    anchorEntity.addChild(modelEntity)
                    
                    self.scene.addAnchor(anchorEntity)
                    self.sessionModelEntities.append(StoreModelEntity(transform: anchor.transform, name: presenter.objectToAdd!.modelName, type: .parchment, size: modelEntity.scale, identifier: presenter.objectToAdd!.identifier))
                    
                } else {
                    print("DEBUG: Unable to load modelEntity for")
                }
                
                presenter.buttonItemsID = .initialSelect
            } else if(anchor.name!.hasPrefix(Utils.treasurePrefix.rawValue) ){
                virtualObjectAnchor = anchor
                
                
                if let modelEntity = presenter.objectToAdd?.modelEntity {
                    print("DEBUG: adding model to scene -")
                    
                    modelEntity.generateCollisionShapes(recursive: true)
                    
                    self.installGestures([.rotation, .scale], for: modelEntity).forEach { entityGesture in
                            entityGesture.addTarget(self, action: #selector(handleEntityGesture(_:)))
                        }
                    
                    // Add modelEntity and anchorEntity into the scene for rendering
                    let anchorEntity = AnchorEntity(anchor: anchor)
                    modelEntity.type = .none
                    modelEntity.identifier = presenter.objectToAdd!.identifier
                    anchorEntity.addChild(modelEntity)
                    
                    self.scene.addAnchor(anchorEntity)
                    self.sessionModelEntities.append(StoreModelEntity(transform: anchor.transform, name: presenter.objectToAdd!.modelName, type: .treasure, size: modelEntity.scale, identifier: presenter.objectToAdd!.identifier))
                    presenter.treasurePlaced = true
                    presenter.buttonItemsID = .initialSelect
                    presenter.objectToAdd = nil
                    
                } else {
                    print("DEBUG: Unable to load modelEntity for")
                }
            } else if(anchor.name == "actionButtons") {
                
                let deleteButtonEntity = ARActionButton(type: .delete)
                let modifyButtonEntity = ARActionButton(type: .modify)
                
                
                let anchorEntityPlane = AnchorEntity(anchor: anchor)
                anchorEntityPlane.generateCollisionShapes(recursive: false)
                anchorEntityPlane.setPosition(SIMD3<Float>(0.00, tappedObject!.scale.y / 4, 0.00), relativeTo: nil)
                
                
                anchorEntityPlane.addChild(deleteButtonEntity.modelEntity!)
                if(!tappedObject!.name.hasPrefix(Utils.treasurePrefix.rawValue)) {
                    anchorEntityPlane.addChild(modifyButtonEntity.modelEntity!)
                }
                
                
                
                if(!tappedObject!.name.hasPrefix(Utils.treasurePrefix.rawValue)) {
                    modifyButtonEntity.modelEntity!.setPosition(SIMD3<Float>(0.06, 0.0001, 0), relativeTo: anchorEntityPlane)
                    modifyButtonEntity.modelEntity!.orientation = simd_quatf(angle: -.pi/2,
                                                                             axis: [1,0,0])
                }
                
                
                deleteButtonEntity.modelEntity!.setPosition(SIMD3<Float>((!tappedObject!.name.hasPrefix(Utils.treasurePrefix.rawValue)) ? -0.06 : 0, 0.0001, 0), relativeTo: anchorEntityPlane)
                deleteButtonEntity.modelEntity!.orientation =
                simd_quatf(angle: -.pi/2,
                           axis: [1,0,0])
                
                
                self.actionButtonsAnchorEntity = anchorEntityPlane
                self.scene.addAnchor(anchorEntityPlane)
            
            } else {
                return
            }
        } else if let presenter = viewPresenter as? PlayViewPresenter {
            
            guard anchor.name != nil else {
                return
            }
            
            if anchor.name!.hasPrefix(Utils.parchmentPrefix.rawValue) {
                
                
                print("Loading parchment model")
                guard let model = presenter.mapSessions[presenter.currentSession].modelEntities.get(anchor.name!.replacingOccurrences(of: Utils.parchmentPrefix.rawValue, with: "")) else {
                    print("Model cannot be loaded")
                    return
                }
                
           
                _ = ParchmentEntity( modelName: model.name, anchorEntity: AnchorEntity(anchor: anchor), scene: self.scene,
                                     parchmentText: model.text,textPosition: model.textPosition, identifier: model.identifier, scale: model.size, orient: model.orient)
                 
                presenter.currentSessionClues += 1
                
                
                /*for offModel in presenter.mapSessions[presenter.currentSession].modelEntities {
                    print("TRANSFORM: offModel:\(offModel.transform) __ anchor:\(anchor.transform)")
                    if (offModel.transform == anchor.transform) {
                        let anchorEntity = AnchorEntity(anchor: anchor)
                       _ = ParchmentEntity( modelName: offModel.name, anchorEntity: anchorEntity, scene: self.scene,
                                            parchmentText: offModel.text,textPosition: offModel.textPosition, identifier: offModel.identifier, scale: offModel.size, orient: offModel.orient)
                        presenter.currentSessionClues += 1
                    }
                }*/
                
            } else if
                
                anchor.name!.hasPrefix(Utils.treasurePrefix.rawValue) {
                
                print("Loading treasure model")
                guard let model = presenter.mapSessions[presenter.currentSession].modelEntities.get(anchor.name!.replacingOccurrences(of: Utils.treasurePrefix.rawValue, with: "")) else {
                    print("Model cannot be loaded")
                    return
                }
                
                _ = TreasureEntity(modelName: model.name, width: Float(model.size.x), height: Float(model.size.y), depth: Float(model.size.z), anchorEntity: AnchorEntity(anchor: anchor), scene: self.scene, identifier: model.identifier,scale: model.size, orient: model.orient)
                
                /*for offModel in presenter.mapSessions[presenter.currentSession].modelEntities {
                    if (offModel.transform == anchor.transform) {
                        let anchorEntity = AnchorEntity(anchor: anchor)
                        _ = TreasureEntity( modelName: offModel.name, width: Float(offModel.size.x), height: Float(offModel.size.y), depth: Float(offModel.size.z), anchorEntity: anchorEntity, scene: self.scene, identifier: offModel.identifier,scale: offModel.size, orient: offModel.orient)
                    }
                }*/
                
                
            }
            
            
        }
        
    }
    
}
