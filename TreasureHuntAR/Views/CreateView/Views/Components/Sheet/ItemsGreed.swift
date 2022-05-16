//
//  ItemsGreed.swift
//  Esercitazione1
//
//  Created by MacBook on 18/04/22.
//

import SwiftUI
import ARKit

struct ItemsGreed: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        VStack(spacing: 25) {
            
            HorizontalView(text: "parchments", type: ModelTypes.parchment).environmentObject(presenter)
            if(!presenter.treasurePlaced) {
                HorizontalView(text: "treasures", type: ModelTypes.treasure
                ).environmentObject(presenter)
            }
           
        }.padding()
    }
}



struct BrowseView: View {
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ItemsGreed(presenter: self.presenter)
            }.navigationBarTitle(Text(LocalizedStringKey("items")), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.presenter.closeSheet()
                }) {
                    Text(LocalizedStringKey("close")).bold().shadow(radius: 2)
                }).background(Color(hex: 0xe7d9bc))
        }
    }
}


