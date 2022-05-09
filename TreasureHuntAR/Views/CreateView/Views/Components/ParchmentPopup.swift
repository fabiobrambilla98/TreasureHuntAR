//
//  ParchmentPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI

struct ParchmentPopup: View {
    @State var testo: String = ""
    @EnvironmentObject var presenter: CreateViewPresenter
    
    var body: some View {
        ZStack(alignment: .center){
            ZStack(alignment: .topLeading) {
                Image(uiImage: UIImage(named: presenter.objectToAdd!.modelName)!).resizable().scaledToFit()
                
                let parchment = presenter.objectToAdd! as! ParchmentEntity
                
                TextEditor(text: self.$testo).offset(x: parchment.offset.x, y: parchment.offset.y).onAppear() {
                    
                    testo = presenter.parchmentText
                    UITextView.appearance().backgroundColor = UIColor(white: 0.0, alpha: 0.0)
                }.onChange(of: testo) { _ in
                    if testo.contains("\n") {
                        presenter.addTextToParchment(testo)
                        presenter.showParchment = false
                        testo = ""
                    }
                    
                }.frame(minWidth: 0, maxWidth: parchment.offset.width)  
            }.frame(minWidth: 0, maxWidth: 250, minHeight: 0, maxHeight: 280)
        }.fullScreen(alignment: .center)
            .transition(AnyTransition.scale.animation(.easeIn(duration: 0.2)))
        
    }
}


