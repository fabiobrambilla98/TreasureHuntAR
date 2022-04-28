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
                .frame(width: 60, height: 60)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        }.buttonStyle(PlainButtonStyle()).shadow(color: Color.white, radius: 4)
    }
}