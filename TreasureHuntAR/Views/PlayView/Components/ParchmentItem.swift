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
        ZStack(alignment: .topLeading) {
            presenter.getImage(named: modelEntity.modelName).resizable().scaledToFit()
            Text(text).frame(minWidth: 0, maxWidth: self.getOffset(axis: .width, for: modelEntity.offset.width)).font(.system(size: 8)).offset(x: self.getOffset(axis: .x, for: modelEntity.offset.x), y: self.getOffset(axis: .y, for: modelEntity.offset.y))
            }.frame(width: 100, height: 100)
                                                                                                                          
                                                                                                                          }
                                                                                                                          
                                                                                                                          private func getOffset(axis: Axis, for value: CGFloat) -> CGFloat{
                switch(axis) {
                case .x, .width:
                    return (100 * value) / 250
                case .y:
                    return (100 * value) / 280
                    
                }
            }
                                                                                                                          }
                                                                                                                          
                                                                                                                          
