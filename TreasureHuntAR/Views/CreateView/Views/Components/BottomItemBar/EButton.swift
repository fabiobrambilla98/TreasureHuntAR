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
        ZStack {
        ZStack {
            Button(action: {
                withAnimation(.easeInOut) {
                    self.presenter.buttonItemsID = itemSelected
                    self.presenter.selectEntityToAdd(name: name)
                    
                }
            }) {
                ZStack{
                    ZStack {
                        Image(uiImage: UIImage(named: name)!).resizable()
                            .scaledToFit()
                    }
                    if(name.hasPrefix("c_") && presenter.treasurePlaced) {
                        ZStack {
                            
                        }.fullScreen(alignment: .center).background(Color.black.opacity(0.5))
                    }
                    
                }
            }.buttonStyle(PlainButtonStyle()).padding(6).disabled(name.hasPrefix("c_") && presenter.treasurePlaced)
        }.frame(width: 50, height: 50).background(Color.secondaryColor).cornerRadius(5)
            
        }.frame(width: 53, height: 53).background(Color.thirdColor).cornerRadius(5)
            
    }
}
