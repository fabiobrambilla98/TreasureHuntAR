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
            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .edgesIgnoringSafeArea(.all)
           
           ZStack(alignment: .topLeading) {
               
               Image(uiImage: UIImage(named: presenter.objectToAdd!.modelName)!).resizable().scaledToFill()
               TextEditor(text: self.$testo).padding(.all).onAppear() {
                   UITextView.appearance().backgroundColor = UIColor(white: 0.0, alpha: 0.0)
               }.onChange(of: testo) { _ in
                   if testo.contains("\n") {
                       self.presenter.showParchment = false
                   }
               }
           }.frame(maxWidth: 160, maxHeight: 280)
              
           
        }.fullScreen(alignment: .center)
           .transition(AnyTransition.scale.animation(.easeIn(duration: 0.2)))
    }
}


