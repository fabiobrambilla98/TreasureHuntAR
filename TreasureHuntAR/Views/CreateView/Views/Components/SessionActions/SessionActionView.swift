//
//  SessionActionView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI

struct SessionActionView: View {
    
    @EnvironmentObject var presenter: CreateViewPresenter
    
    var body: some View {
       
            
            HStack(spacing: 20) {
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        presenter.saveSession()
                    }
                }) {
                    Text((presenter.saveButtonEnabled) ? "Save" : "Scanning...")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .background((presenter.saveButtonEnabled) ? Color.green : Color.gray.opacity(0.8))
                        .cornerRadius(40)
                }.disabled(!presenter.saveButtonEnabled)
                
                if(self.presenter.newSessionButtonVisible) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            presenter.newSession()
                        }
                    }) {
                        Text("New")
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                    }
                }
                
            }
        }
    
}

