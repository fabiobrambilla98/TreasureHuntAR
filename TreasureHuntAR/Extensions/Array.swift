//
//  Array.swift
//  TreasureHuntAR
//
//  Created by MacBook on 28/04/22.
//

import SwiftUI

extension Array where Element == Data {
    mutating func replace(index: Int, with data: Data) {
        self[index] = data
    }
}
