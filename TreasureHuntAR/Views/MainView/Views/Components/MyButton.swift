//
//  MyButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

struct MyButton: View {
    var text: String
    var type: ButtonType
    @State private var selectedType: ButtonType?
    
    var body: some View {
        Button(action: {
            self.selectedType = type
        } ) {
            HStack {
                if(type == .playButton) {
                    Image(systemName: "play").foregroundColor(Color.black)
                } else if (type == .createButton) {
                    Image(systemName: "plus").foregroundColor(Color.black)
                }
                Text(LocalizedStringKey(text))
                    .font(.title2).foregroundColor(Color.black)
            }
            
        }.frame(minWidth: 0, maxWidth: 90)
            .padding()
            .background(Color.white)
            .cornerRadius(40)
            .navigate(using: $selectedType, destination: makeDestination)
        
    }
    
    private func destination(type: ButtonType) -> some View {
        switch(type) {
        case .playButton:
            return AnyView(SelectView(presenter: SelectViewPresenter()))
        case .createButton:
            return AnyView(CreateView(presenter: CreateViewPresenter()))
        }
    }
    
    @ViewBuilder
    private func makeDestination(for type: ButtonType) -> some View {
        switch(type) {
        case .playButton:
            AnyView(SelectView(presenter: SelectViewPresenter()))
        case .createButton:
            AnyView(CreateView(presenter: CreateViewPresenter()))
        }
    }
}


