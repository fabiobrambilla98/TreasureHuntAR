//
//  TreasureHuntCardGreed.swift
//  TreasureHuntAR
//
//  Created by MacBook on 01/05/22.
//

import SwiftUI

struct TreasureHuntCardGreed: View {
    
    @EnvironmentObject var presenter: SelectViewPresenter
    
    
    
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                ForEach(presenter.treasureHuntListNames, id: \.self) {
                    name in TreasureHuntCard(name: name).environmentObject(presenter)
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}

struct TreasureHuntCardGreed_Previews: PreviewProvider {
    static var previews: some View {
        TreasureHuntCardGreed()
    }
}
