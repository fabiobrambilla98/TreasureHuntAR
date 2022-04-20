//
//  Parchment.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI
import RealityKit
import Combine

struct Parchment {
    var modelName: String
    var modelEntity: ModelEntity?
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        
        
        
    }
    
}
