//
//  ItemsGreed.swift
//  Esercitazione1
//
//  Created by MacBook on 18/04/22.
//

import SwiftUI

struct ItemsGreed: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        VStack(spacing: 25) {
            HorizontalView(text: "Parchments", type: ModelTypes.parchment).environmentObject(presenter)
            HorizontalView(text: "Treasures", type: ModelTypes.treasure
            ).environmentObject(presenter)
        }
    }
}



struct BrowseView: View {
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ItemsGreed(presenter: self.presenter)
            }.navigationBarTitle(Text("Items"), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.presenter.closeSheet()
                }) {
                    Text("close").bold()
                })
        }
    }
}

