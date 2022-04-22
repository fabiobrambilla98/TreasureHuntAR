//
//  SessionActionView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI

struct SessionActionView: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    
    var body: some View {
       
            
            HStack(spacing: 20) {
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        presenter.saveWorldMap()
                    }
                }) {
                    
                    Text("Save")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(40)
                }
                
                if(self.presenter.saveSessionButtonPressed) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            
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

