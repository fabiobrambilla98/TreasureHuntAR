//
//  ParchmentItem.swift
//  TreasureHuntAR
//
//  Created by MacBook on 02/05/22.
//

import SwiftUI

struct ParchmentItem: View {
    
    enum Axis {
        case x, y, width
    }
    
    @EnvironmentObject var presenter: PlayViewPresenter
    var modelEntity: ParchmentEntity
    var text: String
    var body: some View {
        ZStack(alignment: .center) {
            Button(action: {
                presenter.parchmentSheetSelected = (modelEntity, text)
                presenter.showParchment = true
            }) {
                ZStack {
                    ZStack(alignment: .topLeading) {
                        presenter.getImage(named: modelEntity.modelName).resizable().scaledToFit()
                      
                            Text(text).frame(width: self.getOffset(axis: .width, for: modelEntity.offset.width), alignment: .leading).font(.system(size: 8)).offset(x: self.getOffset(axis: .x, for: modelEntity.offset.x), y: self.getOffset(axis: .y, for: modelEntity.offset.y)).foregroundColor(Color.white)
   
                    }
                }.padding().frame(width: 100, height: 100,alignment: .center)
            }.frame(width: 100, height: 100, alignment: .center).background(Color(hex: 0xe1cea6)).border(Color(hex: 0xbbb086), width: 1.5)
        }
    }
    
    private func getOffset(axis: Axis, for value: CGFloat) -> CGFloat{
        switch(axis) {
        case .x:
            return ((100 * value) / 250)/2
        case .y:
            return (100 * value) / 280
        case .width:
            return ((100 * value) / 250)
            
        }
    }
}


