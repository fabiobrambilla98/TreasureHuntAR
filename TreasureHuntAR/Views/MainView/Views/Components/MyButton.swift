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
    @State var isActive = false
    var body: some View {
        return NavigationLink(destination: destination(type: type), isActive: $isActive) {
            Button(action: {
                isActive = true
            } ) {
                Text(LocalizedStringKey(text))
                    .font(.title)
            }.frame(minWidth: 0, maxWidth: 90)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkBlue"), Color("LightBlue")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
        }
    }
    
    private func destination(type: ButtonType) -> some View {
        switch(type) {
        case .playButton:
            return AnyView(SelectView(presenter: SelectViewPresenter()))
        case .createButton:
            return AnyView(CreateView(presenter: CreateViewPresenter()))
        }
    }
    
    
}


