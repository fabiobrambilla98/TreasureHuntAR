//
//  SheetParchmentContainer.swift
//  TreasureHuntAR
//
//  Created by MacBook on 02/05/22.
//

import SwiftUI

struct ParchmentGreed: View {
    
    @EnvironmentObject var presenter: PlayViewPresenter
    
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                ForEach(0 ..< presenter.parchmentsFound.count, id: \.self) {
                    index in ParchmentItem(modelEntity: presenter.parchmentsFound[index].0, text: presenter.parchmentsFound[index].1).environmentObject(presenter)
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}

struct BrowseParchmentView: View {
    @EnvironmentObject var presenter: PlayViewPresenter
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ParchmentGreed().environmentObject(presenter)
            }.navigationBarTitle(Text("Parchments"), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.presenter.showParchmentSheet = false
                }) {
                    Text("close").bold()
                })
        }
    }
}


