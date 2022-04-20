//
//  MyHorizontalGreed.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI

struct MyHorizontalGreed: View {
    
    let text: String
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(self.text))
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< presenter.parchementNames.count, id: \.self) { index in
                        Button(action: {
                            self.presenter.lastSelected.updateLast(presenter.parchementNames[index])
                            self.presenter.buttonItemsID = .firstIconSelect
                        }) {
                            Image(uiImage: UIImage(named: presenter.parchementNames[index])!).resizable().frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
    }
}


