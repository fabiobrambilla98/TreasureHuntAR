//
//  CustomModelEntity.swift
//  TreasureHuntAR
//
//  Created by MacBook on 06/05/22.
//

import RealityKit
import ARKit

class CustomModelEntity: Entity, HasModel, HasCollision {
    
    var width: Float? = nil
    var height: Float? = nil
    var depth: Float? = nil
    var tapped: Bool = false
    var identifier: UUID? = nil
    var objectEntity: ObjectEntity? = nil
    var parchmentText: String? = nil
   
    
    required init(mesh: MeshResource, materials: [Material]) {
        super.init()
        self.model = ModelComponent(mesh: mesh, materials: materials)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    
}
