//
//  XButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct XButton: View {
    
    @EnvironmentObject var presenter: CreateViewPresenter
    
    
    
    var body: some View {
        Button(action: {
            switch(presenter.buttonItemsID) {
            case .firstIconSelect:
                presenter.lastSelected.updateLast(presenter.lastSelected[0])
            case .secondIconSelect:
                presenter.lastSelected.updateLast(presenter.lastSelected[1])
            case .initialSelect:
                return
            }
            
            withAnimation(.easeInOut) {
                presenter.deselectEntityToAdd()
                presenter.buttonItemsID = .initialSelect
            }
            
        }) {
            Image(systemName: "xmark").resizable().frame(width: 23, height: 23)
                .foregroundColor(Color.red)
        }.padding(.trailing).buttonStyle(PlainButtonStyle()).shadow(radius: 8)
    }
}


