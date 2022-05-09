//
//  Entity.swift
//  TreasureHuntAR
//
//  Created by MacBook on 24/04/22.
//

import SwiftUI
import RealityKit

extension View {
    @ViewBuilder
    func navigate<Value, Destination: View>(
        using binding: Binding<Value?>,
        @ViewBuilder destination: (Value) -> Destination
    ) -> some View {
        background(NavigationLink(binding, destination: destination))
    }
}

extension NavigationLink where Label == EmptyView {
    init?<Value>(
        _ binding: Binding<Value?>,
        @ViewBuilder destination: (Value) -> Destination
    ) {
        guard let value = binding.wrappedValue else {
            return nil
        }

        let isActive = Binding(
            get: { true },
            set: { newValue in if !newValue { binding.wrappedValue = nil } }
        )

        self.init(destination: destination(value), isActive: isActive, label: EmptyView.init)
    }
}


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


extension ARView {
    struct Presenter {
        @ObservedObject static var _presenter = Presenters()
    }
    
    var viewPresenter: Presenters? {
        get {
            return Presenter._presenter
        }
        set(newValue) {
            Presenter._presenter = newValue!
        }
    }
}
