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


extension CustomARView {
    
    func addTextToParchment(text: String){
        
        
        let parchmentEntity = presenter.presenter.objectToAdd as! ParchmentEntity
        
        
        let mesh = MeshResource.generateText(
                    text,
                    extrusionDepth: 0.0001,
                    font: .systemFont(ofSize: 0.01),
                    containerFrame: CGRect(x: 0, y: 0, width: 0.3, height: 0.3),
                    alignment: .left,
                    lineBreakMode: .byWordWrapping)
        
        let sm = UnlitMaterial(color: UIColor.white)
        let textEntity = ModelEntity(mesh: mesh, materials: [sm])
        
        var modelEntity: Entity
        
        if(presenter.presenter.parchmentToModify == nil) {
            modelEntity = (presenter.presenter.objectToAdd?.modelEntity!)! as Entity
        } else {
            modelEntity = presenter.presenter.parchmentToModify!
        }
       
        
        let screenScale = UIScreen.main.scale
     
        let xWidth = Float(
            Float(parchmentEntity.width) * Float(parchmentEntity.offset.x * screenScale * 0.0002645833))
        let yWidth = Float(250*screenScale*0.0002645833)
        
        let xHeight = Float(
            Float(parchmentEntity.height) * Float(parchmentEntity.offset.y * screenScale * 0.0002645833))
        let yHeight = Float(280*screenScale*0.0002645833)
        
        modelEntity.objectEntity = parchmentEntity
        modelEntity.parchmentText = text
        
        textEntity.name = "parchmentText"
        modelEntity.addChild(textEntity)
        textEntity.setPosition(SIMD3<Float>(-presenter.presenter.objectToAdd!.width/2 + xWidth/yWidth, -presenter.presenter.objectToAdd!.height/2 - xHeight/yHeight, 0.001), relativeTo: modelEntity)
        
        
        
        self.scene.addAnchor(modelEntity.anchor!)
        
    }
    
   
    
    func addAnchorEntityToScene(anchor: ARAnchor) {
        
        if(anchor.name == "parchment") {
            virtualObjectAnchor = anchor
            
            
            if let modelEntity = presenter.presenter.objectToAdd?.modelEntity {
                print("DEBUG: adding model to scene -")

                modelEntity.generateCollisionShapes(recursive: true)
                
                self.installGestures([.rotation, .scale], for: modelEntity)
                
                // Add modelEntity and anchorEntity into the scene for rendering
                let anchorEntity = AnchorEntity(anchor: anchor)
                modelEntity.type = .none
                modelEntity.name = "parchment"
               
                anchorEntity.addChild(modelEntity)
               
                self.scene.addAnchor(anchorEntity)
      
            } else {
                print("DEBUG: Unable to load modelEntity for")
            }
       
            presenter.presenter.buttonItemsID = .initialSelect
        } else if(anchor.name == "parchmentActionButtons") {
            
            let deleteButtonEntity = ARActionButton(type: .delete)
            let modifyButtonEntity = ARActionButton(type: .modify)
            
            var transparentMaterial = UnlitMaterial(color: UIColor.yellow)
            transparentMaterial.color = .init(tint: .white.withAlphaComponent(0))
            
            let actionButtonContainer = ModelEntity(mesh: MeshResource.generatePlane(width: 0.3, depth: 0.1), materials: [transparentMaterial])
           
             let anchorEntityPlane = AnchorEntity(anchor: anchor)
            
             
            
            actionButtonContainer.setPosition(SIMD3<Float>(0.00, 0.22, 0.00), relativeTo: anchorEntityPlane)
   
            actionButtonContainer.orientation = simd_quatf(angle: -.pi/2,
                                                         axis: [1,0,0])
           
            actionButtonContainer.addChild(modifyButtonEntity.modelEntity!)
            actionButtonContainer.addChild(deleteButtonEntity.modelEntity!)
            
            
            anchorEntityPlane.addChild(actionButtonContainer)
            
            modifyButtonEntity.modelEntity!.setPosition(SIMD3<Float>(0.06, 0.001, 0.001), relativeTo: actionButtonContainer)
            modifyButtonEntity.modelEntity!.orientation = simd_quatf(angle: .pi, axis:  [0,1,0])
            
            deleteButtonEntity.modelEntity!.setPosition(SIMD3<Float>(-0.06, 0.001, 0.001), relativeTo: actionButtonContainer)
            deleteButtonEntity.modelEntity!.orientation = simd_quatf(angle: .pi, axis:  [0,1,0])
           
            self.actionButtonsAnchorEntity = anchorEntityPlane
            self.scene.addAnchor(anchorEntityPlane)
            
           
          
        } else {
            return
        }
        
    }
    
}

