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
  
    
    init(modelName: String, width: Float, height: Float, depth: Float) {
        super.init(name: modelName, width: width, height: height, depth: depth)
       
        let filename = modelName + ".usdz"
        
        print("DEBUG: filename > \(filename)")
        self.cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: {
            completion in
                            if case let .failure(error) = completion {
                                print("DEBUG: Unable to load a model due to error \(error)")
                                Observed.shared.showPopUp(text: "DEBUG: Unable to load a model due to error \(error)")
                            }
                            self.cancellable?.cancel()
        }, receiveValue: {
            modelEntity in
            self.modelEntity = modelEntity
            self.modelEntity?.transform.scale = SIMD3<Float>(width/100, height/100, depth/100)
            self.modelEntity?.name = "treasure"
            self.setSize(width: width, height: height, depth: depth)
            print("DEBUG: model loaded")
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

