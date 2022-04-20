//
//  ItemsGreed.swift
//  Esercitazione1
//
//  Created by MacBook on 18/04/22.
//

import SwiftUI


extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}



struct ItemsGreed: View {
    
    @Binding var showBrowse: Bool
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        VStack {
            MyHorizontalGreed(text: "parchments", presenter: self.presenter)
        }
    }
}



struct BrowseView: View {
    @Binding var showBrowse: Bool
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ItemsGreed(showBrowse: $showBrowse, presenter: self.presenter)
            }.navigationBarTitle(Text("Items"), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.showBrowse.toggle()
                }) {
                    Text("close").bold()
                })
        }
    }
}

