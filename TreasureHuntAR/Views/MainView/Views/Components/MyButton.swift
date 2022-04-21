//
//  MyButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

struct MyButton<P: MainViewPresenting & ContentFlowStateProtocol>: View {
    
    var text: String
    var type: ButtonType
    @StateObject var presenter: P
    
    var body: some View {
        return Button(action: {
            switch(type) {
            case .playButton:
                presenter.open(ViewSelection.playView)
            case .createButton:
                presenter.open(ViewSelection.createView)
            }
        } ) {
            Text(LocalizedStringKey(text)).fontWeight(.bold)
                .font(Font.custom("treasure", size: 30))
        }.frame(minWidth: 0, maxWidth: 90)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkBlue"), Color("LightBlue")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
    }
}


