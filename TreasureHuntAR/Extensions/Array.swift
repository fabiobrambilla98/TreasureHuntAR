//
//  Array.swift
//  TreasureHuntAR
//
//  Created by MacBook on 28/04/22.
//

import SwiftUI
import RealityKit

extension Array where Element == SessionData {
    mutating func replace(index: Int, with data: SessionData) {
        self[index] = data
    }
}


extension Array where Element == String {
    mutating func remove(_ element: String) {
        self = self.filter(){$0 != element}
    }
}

extension Array where Element == (String, UIImage) {
    mutating func remove(_ element: String) {
        self = self.filter(){$0.0 != element}
    }
}

extension Array where Element == StoreModelEntity {
    mutating func remove(_ id: UUID) {
        self = self.filter(){$0.identifier != id}
    }
}

