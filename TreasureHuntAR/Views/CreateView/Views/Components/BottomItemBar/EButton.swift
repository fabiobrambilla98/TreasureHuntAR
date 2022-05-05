//
//  EButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct EButton: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    var itemSelected: ButtonItemsIDs
    @Binding var name: String
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                self.presenter.buttonItemsID = itemSelected
                self.presenter.selectEntityToAdd(name: name)
                
            }
        }) {
            Image(uiImage: UIImage(named: name)!).resizable()
                .scaledToFit()
        }.buttonStyle(PlainButtonStyle())
            .cornerRadius(5)
            .frame(minWidth: 0, maxWidth: 60, minHeight: 0, maxHeight: 60)
    }
}
