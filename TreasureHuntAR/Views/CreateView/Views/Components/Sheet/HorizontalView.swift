//
//  HorizontalView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 26/04/22.
//

import SwiftUI

struct HorizontalView: View {
    @EnvironmentObject var presenter: CreateViewPresenter
    var text: String
    var type: ModelTypes
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(self.text)).shadow(radius: 2)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< ((type == .parchment) ? presenter.parchmentImages.count : presenter.treasureImages.count), id: \.self) { index in
                        Button(action: {
                            if(type == .parchment) {
                                self.presenter.selectEntityToAdd(name: presenter.parchmentImages[index].0)
                                self.presenter.lastSelected.updateLast(presenter.parchmentImages[index].0)
                            } else if(type == .treasure) {
                                self.presenter.selectEntityToAdd(name: presenter.treasureImages[index].0)
                                self.presenter.lastSelected.updateLast(presenter.treasureImages[index].0)
                            }
                            self.presenter.buttonItemsID = .firstIconSelect
                            
                        }) {
                            if(type == .parchment) {
                                Image(uiImage: presenter.parchmentImages[index].1).resizable().padding()
                            } else {
                                Image(uiImage: presenter.treasureImages[index].1).resizable().scaledToFit().padding()
                            }
                        }.frame(width: 100, height: 100).background(Color(hex: 0xe1cea6)).border(Color(hex: 0xbbb086), width: 1.5)
                    }
                }
            }
        }
    }
}

