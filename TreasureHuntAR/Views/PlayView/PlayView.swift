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
            
            if(!presenter.treasureFound) {
                ZStack(alignment: .center) {
                    
                    
                    HStack(spacing: 60) {
                        ZStack {
                            ZStack {
                                Button(action: {
                                    self.presenter.showMapSheet = true
                                }) {
                                    Image(systemName: "lightbulb.circle.fill").resizable().scaledToFit().foregroundColor(Color.white).shadow(radius:3)
                                }.sheet(isPresented: self.$presenter.showMapSheet) {
                                    MapSheet(presenter: presenter).navigationBarHidden(true)
                                }.padding(5)
                            }.frame(width: 40, height: 40).background(Color.secondaryColor).cornerRadius(6)
                            
                        }.frame(width: 43, height: 43).background(Color.thirdColor).cornerRadius(6)
                        ZStack{
                            ZStack{
                        Button(action: {
                            self.presenter.showParchmentSheet = true
                        }) {
                            Image(systemName: "archivebox.circle.fill").resizable().foregroundColor(Color.white).shadow(radius:3)
                        
                        }.sheet(isPresented: self.$presenter.showParchmentSheet) {
                            BrowseParchmentView().environmentObject(presenter)
                        }.padding(5)
                    }.frame(width: 40, height: 40).background(Color.secondaryColor).cornerRadius(6)
                    
                }.frame(width: 43, height: 43).background(Color.thirdColor).cornerRadius(6)
                        
                        if(presenter.sessionClueFound >= presenter.currentSessionClues && presenter.currentSession < presenter.mapSessions.count - 1 && presenter.currentSessionClues != 0) {
                            SessionButton(type: .next).environmentObject(presenter)
                        }
                        
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70).background(Color.primaryColor.opacity(0.5))
            }
            
            if(presenter.treasureFound) {
                TreasureFoundPopup().navigationBarHidden(true)
            }
            
            
        }.fullScreen(alignment: .bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(presenter: self.presenter), trailing: HStack {
                VStack {
                    Text(LocalizedStringKey("parchments"))
                    ZStack {
                        Text("\(presenter.parchmentsFound.count)/\(presenter.currentSessionClues)").foregroundColor(Color.white).shadow(radius: 3)
                    }.frame(width: 40, height:30).background(Color.secondaryColor.opacity(0.4))
                        .cornerRadius(10)
                }
                VStack {
                    Text(LocalizedStringKey("session"))
                    ZStack {
                        Text("\(presenter.currentSession + 1)/\(presenter.mapSessions.count)").foregroundColor(Color.white).shadow(radius: 3)
                    }.frame(width: 40, height:30).background(Color.secondaryColor.opacity(0.4)).cornerRadius(10)
                }}.padding(.top))
        
    }
    
    
}

