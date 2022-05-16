//
//  Color.swift
//  TreasureHuntAR
//
//  Created by MacBook on 12/05/22.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension Color {
    static var primaryColor: Color {
        get {
            return Color(hex: 0xe7d9bc)
        }
    }
    static var secondaryColor: Color {
        get {
            return Color(hex: 0xe1cea6)
        }
    }
    static var thirdColor: Color {
        get {
            return Color(hex: 0xbbb086)
        }
    }
}
