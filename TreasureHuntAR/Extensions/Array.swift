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


