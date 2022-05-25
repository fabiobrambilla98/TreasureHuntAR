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


extension Array where Element == StoreModelEntity {
    mutating func get(_ identifier: String) -> StoreModelEntity? {
        let returnItem = self.filter(){$0.identifier.uuidString == identifier}
        
        if returnItem.isEmpty {
            return nil
        }
        
        return returnItem[0]
       
    }
}

extension Array where Element == String {
    mutating func updateLast(_ item: String) {
        guard self.count > 1 else {
            return
        }
        if(item != self[0] && item != self[1]) {
            self[1] = self[0]
            self[0] = item
        } else if(item == self[1]) {
            let temp = self[0]
            self[0] = self[1]
            self[1] = temp
        }
    }
}
