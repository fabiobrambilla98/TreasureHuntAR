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
                ZStack {
                    Image(uiImage: UIImage(named: presenter.objectToAdd!.modelName)!).resizable().scaledToFit()
                }.frame(width: 250, height: 280)
                
                let parchment = presenter.objectToAdd! as! ParchmentEntity
                
                TextEditor(text: self.$testo).font(.system(size: 18)).offset(x: parchment.offset.x, y: parchment.offset.y).onAppear() {
                    
                    testo = presenter.parchmentText
                    UITextView.appearance().backgroundColor = UIColor(white: 0.0, alpha: 0.0)
                }.onChange(of: testo) { _ in
                    if testo.contains("\n") {
                        presenter.addTextToParchment(testo)
                        presenter.showParchment = false
                        testo = ""
                    }
                    
                }.frame(minWidth: 0, maxWidth: parchment.offset.width)  
            }.frame(width: 250, height: 280).edgesIgnoringSafeArea(.all)
        }.fullScreen(alignment: .center)
            .transition(AnyTransition.scale.animation(.easeIn(duration: 0.2)))
        
    }
}




