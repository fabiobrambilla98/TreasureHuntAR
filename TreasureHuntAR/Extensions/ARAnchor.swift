//
//  ARAnchor.swift
//  TreasureHuntAR
//
//  Created by MacBook on 08/05/22.
//

import RealityKit
import ARKit

protocol ARIds {
    var arID: UUID? {get set}
}

extension ARAnchor: ARIds {
    
    struct ID {
        static var _identifier: UUID? = nil
    }
    
    var arID: UUID? {
        get {
            return ID._identifier
        }
        set {
            ID._identifier = newValue
        }
    }
 
}
