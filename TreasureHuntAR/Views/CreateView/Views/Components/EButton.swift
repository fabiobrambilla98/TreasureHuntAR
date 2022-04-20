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
            self.presenter.buttonItemsID = itemSelected
            
        }) {
            Image(uiImage: UIImage(named: name)!).resizable()
                .frame(width: 55, height: 55)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        }.buttonStyle(PlainButtonStyle()).shadow(radius: 8)
    }
}
