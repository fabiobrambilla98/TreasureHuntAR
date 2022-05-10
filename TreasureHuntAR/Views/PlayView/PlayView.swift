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
            
            ZStack(alignment: .topTrailing) {
                HStack {
                    VStack {
                        Text("Parchment")
                        ZStack {
                            Text("\(presenter.parchmentsFound.count)/\(presenter.currentSessionClues)").foregroundColor(Color.white)
                        }.frame(width: 40, height:30).background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                    VStack {
                        Text("Session")
                        ZStack {
                            Text("\(presenter.currentSession + 1)/\(presenter.mapSessions.count)").foregroundColor(Color.white)
                        }.frame(width: 40, height:30).background(Color.black.opacity(0.4)).cornerRadius(10)
                    }
                }.padding(.top, 40)
                    .padding(.trailing)
            }.fullScreen(alignment: .topTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
            
            ZStack(alignment: .center) {
                
                
                HStack(spacing: 40) {
                    Button(action: {
                        self.presenter.showMapSheet = true
                    }) {
                        Image(systemName: "lightbulb.circle.fill").resizable().frame(width: 40, height: 40).scaledToFit().padding().foregroundColor(Color.white)
                    }.sheet(isPresented: self.$presenter.showMapSheet) {
                        MapSheet(presenter: presenter).navigationBarHidden(true)
                    }
                    
                    
                    Button(action: {
                        self.presenter.showParchmentSheet = true
                    }) {
                        Image(systemName: "archivebox.circle.fill").resizable().frame(width: 40, height: 40).scaledToFit().padding().foregroundColor(Color.white)
                    }.sheet(isPresented: self.$presenter.showParchmentSheet) {
                        BrowseParchmentView().environmentObject(presenter)
                    }
                  
                    if(presenter.sessionClueFound >= presenter.currentSessionClues && presenter.currentSession < presenter.mapSessions.count - 1 && presenter.currentSessionClues != 0) {
                        SessionButton(type: .next).environmentObject(presenter)
                    }
                   
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70).background(Color.black.opacity(0.5))
           
            if(presenter.treasureFound) {
                TreasureFoundPopup()
            }
            
            
        }.fullScreen(alignment: .bottom)
            
    }
    
   
}

