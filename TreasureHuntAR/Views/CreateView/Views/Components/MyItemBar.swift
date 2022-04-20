//
//  MyItemBar.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct MyItemBar: View {
    
    typealias B = ButtonItemsIDs
    @ObservedObject var presenter: CreateViewPresenter
    @Binding var showBrowse: Bool
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.black)
                .opacity(0.5)
                .frame(width: 230, height: 80)
            
            
            HStack(spacing: 15){
                
                if(self.presenter.buttonItemsID != .initialSelect) {
                    Button(action: {
                        switch(self.presenter.buttonItemsID) {
                        case .firstIconSelect:
                            self.presenter.lastSelected.updateLast(self.presenter.lastSelected[0])
                        case .secondIconSelect:
                            self.presenter.lastSelected.updateLast(self.presenter.lastSelected[1])
                        case .initialSelect:
                            return
                        }
                        self.presenter.buttonItemsID = B.initialSelect
                        
                        
                    }) {
                        Image(systemName: "xmark").resizable().frame(width: 23, height: 23)
                            .foregroundColor(Color.red)
                    }.padding(.trailing).buttonStyle(PlainButtonStyle()).shadow(radius: 8)
                    
                    
                }
                
                if(self.presenter.buttonItemsID == .initialSelect || self.presenter.buttonItemsID == .firstIconSelect) {
                    EButton(presenter: self.presenter,itemSelected: B.firstIconSelect, name: self.$presenter.lastSelected[0])
                    
                }
                if(self.presenter.buttonItemsID == .initialSelect || self.presenter.buttonItemsID == .secondIconSelect) {
                    
                    EButton(presenter: self.presenter, itemSelected: B.secondIconSelect, name: self.$presenter.lastSelected[1])
                    
                    
                }
                if(self.presenter.buttonItemsID == .initialSelect) {
                    Button(action: {
                        self.showBrowse = true
                    }) {
                        Image(systemName: "circle.grid.3x3.circle.fill").resizable().frame(width: 45, height: 45)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $showBrowse) {
                        BrowseView(showBrowse: $showBrowse, presenter: self.presenter)
                    }
                    .buttonStyle(PlainButtonStyle()).shadow(radius: 8)
                    
                    
                }
            }
        }
        .padding(.bottom).animation(.easeInOut)
    }
}

