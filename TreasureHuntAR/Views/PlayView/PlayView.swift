//
//  PlayView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

struct PlayView: View {
    @ObservedObject var presenter: PlayViewPresenter

    var body: some View {
        
        ZStack(alignment: .bottom){
            
            ARViewContainer(presenter: presenter).edgesIgnoringSafeArea(.all)
            
            HStack {
                Spacer()
                Button(action: {}) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Previ")
                    }.frame(width: 100, alignment: .trailing)
                }
                Spacer()
                Button(action: {
                    self.presenter.showParchmentSheet = true
                }) {
                    Image(systemName: "archivebox.circle").resizable().frame(width: 50, height: 50).padding()
                }.sheet(isPresented: self.$presenter.showParchmentSheet) {
                    BrowseParchmentView().environmentObject(presenter)
                }
                Spacer()
                Button(action: {}) {
                    HStack {
                        
                        Text("Next")
                        
                        Image(systemName: "chevron.right")
                    }.frame(width: 100, alignment: .leading)
                }
                Spacer()
            }
        }.fullScreen(alignment: .bottom).padding(.bottom)
         
        
    }
    
   
}

