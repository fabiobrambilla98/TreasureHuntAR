//
//  SessionData.swift
//  TreasureHuntAR
//
//  Created by MacBook on 04/05/22.
//

import RealityKit
import ARKit
import SwiftUI

extension simd_float4x4: Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        try self.init(container.decode([SIMD4<Float>].self))
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode([columns.0,columns.1, columns.2, columns.3])
    }
}


class StoreModelEntity: Codable {
    var transform: simd.float4x4
    var name: String
    var type: ModelTypes
    var size: SIMD3<Float>
    var position: SIMD3<Float>
    var text: String
    var identifier: UUID
    
    
    private enum CodingKeys: String, CodingKey {
        case transform
        case name
        case type
        case size
        case position
        case text
        case identifier
    }
    
    init(transform: simd.float4x4, name: String, type: ModelTypes, size: SIMD3<Float>, position: SIMD3<Float> = SIMD3<Float>.init(), text: String = "", identifier: UUID) {
        self.transform = transform
        self.name = name
        self.type = type
        self.size = size
        self.position = position
        self.text = text
        self.identifier = identifier
    }
    
    
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        transform = try values.decode(simd.float4x4.self, forKey: .transform)
        
        name = try values.decode(String.self, forKey: .name)
        
        type = try values.decode(ModelTypes.self, forKey: .type)
        
        size = try values.decode(SIMD3<Float>.self, forKey: .size)
        
        position = try values.decode(SIMD3<Float>.self, forKey: .position)
        
        text = try values.decode(String.self, forKey: .text)
        
        identifier = try values.decode(UUID.self, forKey: .identifier)
    }
}








class SessionData: Codable{
    
    var sessionWorldMap: Data
    var modelEntities: [StoreModelEntity]
    
    init(data: Data, modelEntities: [StoreModelEntity] = []) {
        sessionWorldMap = data
        self.modelEntities = modelEntities
    }
    
    func serializeObject() -> Data {
        do {
            let data = try JSONEncoder().encode(self)
            return data
        
        } catch {
            fatalError(" \(error)")
        }
    }
    
    
}
