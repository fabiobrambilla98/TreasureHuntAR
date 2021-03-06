//
//  SelectView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 02/05/22.
//

import SwiftUI

struct SelectView: View {
    @ObservedObject var presenter: SelectViewPresenter
    
    var body: some View {
        ZStack{
            ZStack { Image("treasure_play_background").centerCropped().edgesIgnoringSafeArea(.top)
                    
                }.fullScreen(alignment: .center)
                
                
                ZStack {
                }.fullScreen(alignment: .center).background(Color.black.opacity(0.4))
                
                ScrollView {
                    TreasureHuntCardGreed().environmentObject(presenter)
              
            }.navigationBarTitle(LocalizedStringKey("maps"))
        }.fullScreen(alignment: .center)
        
    }
}


