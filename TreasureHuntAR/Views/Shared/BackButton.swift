//
//  BackButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 21/04/22.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var presenter: Presenters
    
    
    var body: some View {
        
        Button(action: {
            self.presenter.showAlert = true
        })
        {
                ZStack {
                    Image(systemName: "chevron.backward").foregroundColor(Color.white).shadow(radius: 3)
                }.frame(width: 38, height: 38).background(Color.secondaryColor.opacity(0.7)).cornerRadius(100)
      
        }
        .alert(isPresented: self.$presenter.showAlert) {
            Alert(
                title: Text(LocalizedStringKey("confirm-back-title")),
                message:
                    (presenter is CreateViewPresenter) ? Text(LocalizedStringKey("confirm-back-subtitle")) : Text(""),
                primaryButton: .default(Text(LocalizedStringKey("exit"))) {
                    self.presentationMode.wrappedValue.dismiss()
                    
                },
                secondaryButton: .cancel()
            )
        }.padding(.top).layoutPriority(.infinity)
            
        
        
    }
}

