//
//  SButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct SButton: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        Button(action: {
            self.presenter.openSheet()
        }) {
            Image(systemName: "square.grid.2x2").resizable()
        }
        .sheet(isPresented: self.$presenter.showBrowse) {
            BrowseView(presenter: self.presenter)
        }
        .buttonStyle(PlainButtonStyle()).frame(width: 50, height: 50)
        .foregroundColor(Color.white)
        .cornerRadius(5)
    }
}

