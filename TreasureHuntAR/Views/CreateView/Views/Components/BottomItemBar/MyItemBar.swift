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
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.black)
                .opacity(0.7)
                .frame(width: 290, height: 85)
            
            HStack(spacing: 20){
                if(self.presenter.buttonItemsID != .initialSelect) {
                    XButton().environmentObject(presenter)
                }
                
                if(self.presenter.buttonItemsID == .initialSelect || self.presenter.buttonItemsID == .firstIconSelect) {
                    if self.$presenter.lastSelected.count > 0 {
                        EButton(presenter: self.presenter,itemSelected: B.firstIconSelect, name: self.$presenter.lastSelected[0])
                        
                    } else {
                        EmptyView()
                    }
                    
                }
                if(self.presenter.buttonItemsID == .initialSelect || self.presenter.buttonItemsID == .secondIconSelect) {
                    
                    if(self.$presenter.lastSelected.count > 1) {
                        EButton(presenter: self.presenter, itemSelected: B.secondIconSelect, name: self.$presenter.lastSelected[1])
                    } else {
                        EmptyView()
                    }
                    
                }
                if(self.presenter.buttonItemsID == .initialSelect) {
                    SButton(presenter: self.presenter)
                }
            }
        }
        .padding(.bottom)
    }
}

