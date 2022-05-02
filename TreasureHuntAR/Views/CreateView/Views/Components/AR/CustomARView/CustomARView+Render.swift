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
        
        
        let parchmentEntity = self.presenter!.objectToAdd as! ParchmentEntity
        
        
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
        
        if(self.presenter!.parchmentToModify == nil) {
            modelEntity = (self.presenter!.objectToAdd?.modelEntity!)! as Entity
        } else {
            modelEntity = self.presenter!.parchmentToModify!
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
        textEntity.setPosition(SIMD3<Float>(-self.presenter!.objectToAdd!.width/2 + xWidth/yWidth, -self.presenter!.objectToAdd!.height/2 - xHeight/yHeight, 0.001), relativeTo: modelEntity)
        
        
        
        self.scene.addAnchor(modelEntity.anchor!)
        
    }
    
    
    
    func addAnchorEntityToScene(anchor: ARAnchor) {
        
        if(anchor.name == "parchment") {
            virtualObjectAnchor = anchor
            
            
            if let modelEntity = self.presenter!.objectToAdd?.modelEntity {
                print("DEBUG: adding model to scene -")
                
                modelEntity.generateCollisionShapes(recursive: true)
                
                self.installGestures([.rotation, .scale], for: modelEntity)
                
                // Add modelEntity and anchorEntity into the scene for rendering
                let anchorEntity = AnchorEntity(anchor: anchor)
                modelEntity.type = .none
                modelEntity.name = "parchment"
                
                anchorEntity.addChild(modelEntity)
                
                self.scene.addAnchor(anchorEntity)
                self.presenter!.buttonItemsID = .initialSelect
                
            } else {
                print("DEBUG: Unable to load modelEntity for")
            }
            
            self.presenter!.buttonItemsID = .initialSelect
        } else if(anchor.name == "treasure" ){
            virtualObjectAnchor = anchor
            
            
            if let modelEntity = self.presenter!.objectToAdd?.modelEntity {
                print("DEBUG: adding model to scene -")
                
                modelEntity.generateCollisionShapes(recursive: true)
                
                self.installGestures([.rotation, .scale], for: modelEntity)
                
                // Add modelEntity and anchorEntity into the scene for rendering
                let anchorEntity = AnchorEntity(anchor: anchor)
                modelEntity.type = .none
                modelEntity.name = "treasure"
                
                anchorEntity.addChild(modelEntity)
                
                self.scene.addAnchor(anchorEntity)
                self.presenter!.buttonItemsID = .initialSelect
                self.presenter!.objectToAdd = nil
                
            } else {
                print("DEBUG: Unable to load modelEntity for")
            }
        } else if(anchor.name == "actionButtons") {
            
            let deleteButtonEntity = ARActionButton(type: .delete)
            let modifyButtonEntity = ARActionButton(type: .modify)
           
            
            let anchorEntityPlane = AnchorEntity(anchor: anchor)
            anchorEntityPlane.generateCollisionShapes(recursive: false)
            anchorEntityPlane.setPosition(SIMD3<Float>(0.00, tappedObject!.height!, 0.00), relativeTo: nil)
            
            
            anchorEntityPlane.addChild(deleteButtonEntity.modelEntity!)
            if(tappedObject!.name != "treasure") {
                anchorEntityPlane.addChild(modifyButtonEntity.modelEntity!)
            }
           
           
            
            if(tappedObject!.name != "treasure") {
                modifyButtonEntity.modelEntity!.setPosition(SIMD3<Float>(0.06, 0.0001, 0), relativeTo: anchorEntityPlane)
                modifyButtonEntity.modelEntity!.orientation = simd_quatf(angle: -.pi/2,
                                                                         axis: [1,0,0])
            }
          
            
            deleteButtonEntity.modelEntity!.setPosition(SIMD3<Float>((tappedObject!.name != "treasure") ? -0.06 : 0, 0.0001, 0), relativeTo: anchorEntityPlane)
            deleteButtonEntity.modelEntity!.orientation =
            simd_quatf(angle: -.pi/2,
                                                                     axis: [1,0,0])
            
            
            self.actionButtonsAnchorEntity = anchorEntityPlane
            self.scene.addAnchor(anchorEntityPlane)
            
            
            
        } else {
            return
        }
        
    }
    
}

