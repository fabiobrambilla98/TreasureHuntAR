//
//  Binding.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

extension Binding {
    func map<T>(get: @escaping (Value) -> T?, set: @escaping (T?) -> Value) -> Binding<T?> {
        Binding<T?>(
            get: {
                get(wrappedValue)
            },
            set: {
                wrappedValue = set($0)
            }
        )
    }
}
