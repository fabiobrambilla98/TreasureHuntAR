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
    
    init(name modelName: String, width: Float = 0, height: Float = 0, depth: Float = 0, entity: CustomModelEntity? = nil, identifier: UUID = UUID()) {
        self.modelName = modelName
        self.modelEntity = entity
        self.width = width
        self.height = height
        self.depth = depth
        self.identifier = identifier
    }
    
    
}
