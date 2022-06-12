//
//  Treasure.swift
//  TreasureHuntAR
//
//  Created by MacBook on 26/04/22.
//

import SwiftUI
import RealityKit
import Combine


class TreasureEntity: ObjectEntity {
    var cancellable: AnyCancellable? = nil
    
    
    init(modelName: String, width: Float, height: Float, depth: Float, anchorEntity: AnchorEntity? = nil, scene: RealityKit.Scene? = nil, identifier: UUID = UUID(),scale: SIMD3<Float>? = nil, orient: Orientation? = nil) {
        super.init(name: modelName, width: width, height: height, depth: depth, identifier: identifier)
        
        let filename = modelName + ".usdz"
        
         self.cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: {
         completion in
         if case let .failure(error) = completion {
         print("DEBUG: Unable to load a model due to error \(error)")
         
         }
         self.cancellable?.cancel()
         }, receiveValue: {
         model in
         self.modelEntity = CustomModelEntity(mesh: model.model!.mesh, materials: model.model!.materials)
         self.modelEntity?.transform.scale = (anchorEntity == nil) ? SIMD3<Float>(width, height, depth) : SIMD3<Float>(width, height, depth)
         self.modelEntity?.name = "\(Utils.treasurePrefix.rawValue)\(identifier.uuidString)"
             self.setSize(width: width, height: height, depth: depth)
             
         self.modelEntity?.objectEntity = self
         self.modelEntity!.identifier = self.identifier
         if(anchorEntity != nil && scene != nil) {
             self.modelEntity!.identifier = identifier
             self.modelEntity!.generateCollisionShapes(recursive: true)
             
             self.modelEntity!.synchronization = nil
             self.modelEntity!.scale = scale!
             self.modelEntity!.orientation = simd_quatf.init(angle: orient!.angle, axis: orient!.axis)
             anchorEntity?.addChild(self.modelEntity!)
             scene?.addAnchor(anchorEntity!)
         }
         })
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSize(width: Float? = nil, height: Float? = nil, depth: Float? = nil) {
        self.modelEntity!.width = width
        self.modelEntity!.height = height
        self.modelEntity!.depth = depth
    }
    
}

