//
//  List.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

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
