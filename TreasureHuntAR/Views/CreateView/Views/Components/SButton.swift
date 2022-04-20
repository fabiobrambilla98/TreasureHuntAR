//
//  SButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct SButton: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    @Binding var showBrowse: Bool
    
    var body: some View {
        Button(action: {
            self.showBrowse = true
        }) {
            Image(systemName: "circle.grid.3x3.circle.fill").resizable().frame(width: 60, height: 60)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        }
        .sheet(isPresented: $showBrowse) {
            BrowseView(showBrowse: $showBrowse, presenter: self.presenter)
        }
        .buttonStyle(PlainButtonStyle()).shadow(radius: 8)
    }
}
