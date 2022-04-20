//
//  XButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct XButton: View {
    
    @Binding var lastSelected: [String]
    @Binding var buttonItemsID: ButtonItemsIDs
    
    var body: some View {
        Button(action: {
            switch(buttonItemsID) {
            case .firstIconSelect:
                lastSelected.updateLast(lastSelected[0])
            case .secondIconSelect:
                lastSelected.updateLast(lastSelected[1])
            case .initialSelect:
                return
            }
            
            withAnimation(.easeInOut) {
                buttonItemsID = .initialSelect
            }
            
        }) {
            Image(systemName: "xmark").resizable().frame(width: 23, height: 23)
                .foregroundColor(Color.red)
        }.padding(.trailing).buttonStyle(PlainButtonStyle()).shadow(radius: 8)
    }
}


