//
//  BackButton.swift
//  TreasureHuntAR
//
//  Created by MacBook on 21/04/22.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var presenter: CreateViewPresenter
    
    
    var body: some View {
        
        Button(action: {
            self.presenter.showBackAlert()
        })
        {
                ZStack {
                    Image(systemName: "chevron.backward").foregroundColor(Color.white)
                }.frame(width: 38, height: 38).background(Color.black.opacity(0.7)).cornerRadius(100)
      
        }
        .alert(isPresented: self.$presenter.showAlert) {
            Alert(
                title: Text(LocalizedStringKey("confirm-back-title")),
                message: Text(LocalizedStringKey("confirm-back-subtitle")),
                primaryButton: .default(Text(LocalizedStringKey("exit"))) {
                    self.presentationMode.wrappedValue.dismiss()
                    
                },
                secondaryButton: .cancel()
            )
        }.padding(.top).layoutPriority(.infinity)
            
        
        
    }
}

