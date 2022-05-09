//
//  ParchmentPlayPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 07/05/22.
//

import SwiftUI

struct ParchmentPlayPopup: View {
    @EnvironmentObject var presenter: PlayViewPresenter
    
    var body: some View {
        ZStack(alignment: .center){
            ZStack(alignment: .topLeading) {
                Image(uiImage: UIImage(named: presenter.parchmentSheetSelected!.0.modelName)!).resizable().scaledToFit()
                    Text("\(presenter.parchmentSheetSelected!.1)").offset(x: presenter.parchmentSheetSelected!.0.offset.x, y: presenter.parchmentSheetSelected!.0.offset.y).onAppear() {
                        UITextView.appearance().backgroundColor = UIColor(white: 0.0, alpha: 0.0)
                    }.frame(minWidth: 0, maxWidth: presenter.parchmentSheetSelected!.0.offset.width)
                
            }.frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 280)
        }.fullScreen(alignment: .center)
            .transition(AnyTransition.scale.animation(.easeIn(duration: 0.2)))
        
    }
}



