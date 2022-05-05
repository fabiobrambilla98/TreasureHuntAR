//
//  MainView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

enum ButtonType {
    case playButton, createButton
}

struct MainView: View {
    typealias buttonType = ButtonType
    @State var selection: ViewSelection? = nil
    @ObservedObject var presenter: MainViewPresenter
    
    
    var body: some View {
        ZStack {
            Image(Utils.mainBackground.rawValue).centerCropped()
            
            ZStack {
                
            }.centerCropped().background(Color.black.opacity(0.4))
            
            VStack {
                Image(Utils.mainImage.rawValue).resizable().frame(width: 320, height: 180).padding(.top, 50.0)
                Spacer()
                VStack (spacing: 30){
                    MyButton(text: "play", type: buttonType.playButton, presenter: presenter)
                    MyButton(text: "create", type: buttonType.createButton, presenter: presenter)
                }
                Spacer()
            }.padding(.bottom, 30)
            
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true)
    }
    
    
}


