//
//  Entity.swift
//  TreasureHuntAR
//
//  Created by MacBook on 24/04/22.
//

import SwiftUI
import RealityKit

extension Entity {
    private static var _type: ARActionButtonTypes = .none
    var type: ARActionButtonTypes {
            get {
                return Entity._type
            }
            set(newValue) {
                Entity._type = newValue
            }
        }
}

extension Entity {
    
    struct Size {
        static var _width: Float? = nil
        static var _height: Float? = nil
        static var _depth: Float? = nil
    }
    
    struct ObjectEntityContainer {
        static var _objectEntity: ObjectEntity?
    }
    
    struct TextContainer {
        static var _parchmentText: String? = nil
    }
    
    var width: Float? {
        get {
            return Size._width
        }
        set(newValue) {
            Size._width = newValue
        }
    }
    
    var height: Float? {
        get {
            return Size._height
        }
        set(newValue) {
            Size._height = newValue
        }
    }
    
    var depth: Float? {
        get {
            return Size._depth
        }
        set(newValue) {
            Size._depth = newValue
        }
    }
    
    
    var objectEntity: ObjectEntity? {
        get {
            return ObjectEntityContainer._objectEntity
        }
        set(newValue) {
            ObjectEntityContainer._objectEntity = newValue
        }
    }
    
    var parchmentText: String? {
        get {
            return TextContainer._parchmentText
        }
        set(newValue) {
            TextContainer._parchmentText = newValue
        }
    }
    
}
