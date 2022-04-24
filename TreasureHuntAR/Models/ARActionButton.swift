//
//  ARActionButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 24/04/22.
//

import SwiftUI
import RealityKit
import Combine

enum ARActionButtonTypes {
    case delete
    case modify
    case none
}

protocol ARActionButtonProtocol {
    func action()
}

class ARActionButton: ARActionButtonProtocol{
    var modelEntity: Entity?
    var textureRequest: AnyCancellable? = nil
    
    init(_ modelEntity: Entity? = nil, type: ARActionButtonTypes) {
        
        
        do {
            if #available(iOS 15.0, *) {
                let mesh = MeshResource.generatePlane(width: 0.06, depth: 0.06, cornerRadius: 1)
                var material = UnlitMaterial()
                material.color = try .init(tint: .white.withAlphaComponent(0.99),
                                           texture: .init(.load(named: (type == .delete) ? "thresh" : "pencil", in: nil)))
                
                self.modelEntity = ModelEntity(mesh: mesh, materials: [material])
                if(type == .delete) {
                    self.modelEntity!.name = "deleteButton"
                } else {
                    self.modelEntity!.name = "modifyButton"
                }
                self.modelEntity?.type = type
                
                self.modelEntity?.generateCollisionShapes(recursive: true)
             
              
            } else {
                return
            }
        } catch {
            print(error.localizedDescription)
        }
           
         
    }
    
    func action() {}
}

