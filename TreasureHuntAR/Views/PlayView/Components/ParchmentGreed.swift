//
//  SheetParchmentContainer.swift
//  TreasureHuntAR
//
//  Created by MacBook on 02/05/22.
//

import SwiftUI

struct ParchmentGreed: View {
    
    @EnvironmentObject var presenter: PlayViewPresenter
    
    var body: some View {
        
        VStack{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                ForEach(0 ..< presenter.parchmentsFound.count, id: \.self) {
                    index in ParchmentItem(modelEntity: presenter.parchmentsFound[index].0, text: presenter.parchmentsFound[index].1).environmentObject(presenter)
                }
            }
            .padding(.top)
        }.padding(.horizontal)
        
    }
    
}

struct BrowseParchmentView: View {
    @EnvironmentObject var presenter: PlayViewPresenter
    
    var body: some View {
        NavigationView {
            ZStack {
                if(!self.presenter.showParchment) {
                    ScrollView(showsIndicators: false) {
                        ParchmentGreed().environmentObject(presenter)
                    }
                } else if(self.presenter.showParchment) {
                    VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .edgesIgnoringSafeArea(.all).onTapGesture {
                            presenter.showParchment = false
                        }
                    ParchmentPlayPopup().environmentObject(presenter).navigationBarHidden(true).onDisappear(perform: {
                        presenter.parchmentSheetSelected = nil
                    })
                }
                
            }.fullScreen(alignment: .center).navigationBarTitle(Text(LocalizedStringKey("parchments")), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.presenter.showParchmentSheet = false
                }) {
                    Text(LocalizedStringKey("close")).bold()
                }).background(Color(hex: 0xe7d9bc))
            
            
        }.onDisappear(perform: {
            self.presenter.showParchment = false
        })
    }
}


