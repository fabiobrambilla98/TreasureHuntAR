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
    
    
    func addTextToParchment(text: String, entity: ModelEntity?){
        let mesh = MeshResource.generateText(
                    text,
                    extrusionDepth: 0.0001,
                    font: .systemFont(ofSize: 0.01),
                    containerFrame: CGRect(x: 0, y: 0, width: 0.12, height: 0.2),
                    alignment: .left,
                    lineBreakMode: .byWordWrapping)
        
        
        
       
        let sm = UnlitMaterial(color: UIColor.white)
        let textEntity = ModelEntity(mesh: mesh, materials: [sm])
        
        
        entity!.addChild(textEntity)
        textEntity.setPosition(SIMD3<Float>(-0.06, -0.03, 0.001), relativeTo: entity!)
        
        self.scene.addAnchor(entity!.anchor!)
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
                modelEntity.name = virtualObjectAnchorName
                
               
                
                anchorEntity.addChild(modelEntity)
               
                self.scene.addAnchor(anchorEntity)
                
                
                
            } else {
                print("DEBUG: Unable to load modelEntity for")
            }
            
            presenter.presenter.objectToAdd = nil
            presenter.presenter.buttonItemsID = .initialSelect
        } else if(anchor.name == "test") {
            
            if(self.test.anchor != nil) {
                return
            }
            
            var material1 = UnlitMaterial(color: UIColor.red)
            
            var material2 = SimpleMaterial()
           
            
            do {
                if #available(iOS 15.0, *) {
                    material2.color = try .init(tint: .white.withAlphaComponent(0.99),
                                               texture: .init(.load(named: "thresh_3", in: nil)))
                    
                    material1.color = .init(tint: .white.withAlphaComponent(-1))
                } else {
                    return
                }
               
                
            } catch {
                print(error.localizedDescription)
            }
            
         
            let m = MeshResource.generatePlane(width: 0.05, depth: 0.05)
            let e = ModelEntity(mesh:m, materials: [material1])
           
            
            let m1 = MeshResource.generatePlane(width: 0.03, depth: 0.03, cornerRadius: 1)
            
            let e1 = ModelEntity(mesh: m1, materials: [material2])
            
           
           
            let basePlane = AnchorEntity(anchor: anchor)
            e1.generateCollisionShapes(recursive: true)
            basePlane.addChild(e)
            
            e.setPosition(SIMD3<Float>(0.00, 0.06, 0.00), relativeTo: basePlane)
            e.orientation = simd_quatf(angle: -.pi/2,
                                                         axis: [1,0,0])
            
            e.addChild(e1)
            basePlane.name = "test"
            e.name = "test"
            e1.name = "test"
            e1.setPosition(SIMD3<Float>(0.00, 0.001, 0.0), relativeTo: e)
            e1.orientation = simd_quatf(angle: .pi,
                                                         axis: [0,1,0])
            
            
            self.scene.addAnchor(basePlane)
            self.test.anchor = basePlane
            
        } else {
            return
        }
        
    }
    
}

