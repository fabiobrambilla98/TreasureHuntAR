//
//  SessionButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 07/05/22.
//

import SwiftUI

struct SessionButton: View {
    enum ButtonType {
        case next, previous
    }
    
    @EnvironmentObject var presenter: PlayViewPresenter
    var type: ButtonType
    var body: some View {
        if type == .next {
            Button(action: {
                presenter.loadNextSession()
            }) {
                HStack {
                    
                    Text("Next").fontWeight(.semibold).foregroundColor(.white)
                    
                    Image(systemName: "chevron.right").foregroundColor(.white)
                }.frame(minWidth: 0, maxWidth: 60, alignment: .leading)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        } else if type == .previous {
            Button(action: {
                presenter.showNextButton.toggle()
            }) {
                
                HStack {
                    Image(systemName: "chevron.left").foregroundColor(.white)
                    Text("Previ").fontWeight(.semibold).foregroundColor(.white)
                }.frame(minWidth: 0, maxWidth: 60, alignment: .trailing)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        }
    }
}


