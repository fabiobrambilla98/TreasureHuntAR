//
//  ObjectEntity.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import RealityKit
import Combine

class ObjectEntity {
    var modelName: String
    var modelEntity: CustomModelEntity?
    var identifier: UUID
    var width: Float
    var height: Float
    var depth: Float
    var scale: SIMD3<Float>
    var orient: Orientation
    
    init(name modelName: String, width: Float = 0, height: Float = 0, depth: Float = 0, entity: CustomModelEntity? = nil, identifier: UUID = UUID(), scale: SIMD3<Float> = SIMD3<Float>.init(), orient: Orientation = Orientation(angle: 0, axis: SIMD3<Float>.init())) {
        self.modelName = modelName
        self.modelEntity = entity
        self.width = width
        self.height = height
        self.depth = depth
        self.identifier = identifier
        self.scale = scale
        self.orient = orient
    }
    
    
    
}
