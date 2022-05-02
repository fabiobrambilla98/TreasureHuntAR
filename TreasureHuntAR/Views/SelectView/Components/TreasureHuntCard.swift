//
//  TreasureHuntCard.swift
//  TreasureHuntAR
//
//  Created by MacBook on 01/05/22.
//

import SwiftUI

struct TreasureHuntCard: View {
    
    @EnvironmentObject var presenter: SelectViewPresenter
    var name: String
    @State var showingOptions = false
    @State var changeIntoPlayView = false
    
    var body: some View {
        NavigationLink(destination: PlayView(presenter: PlayViewPresenter()), isActive: $changeIntoPlayView) {
            Button(action: {
                self.showingOptions = true
            }) {
                ZStack(alignment: .bottom){
                    
                    Image("treasure_card_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Text(name).font(.headline).foregroundColor(.white)
                        .shadow(color: .black, radius: 3, x: 0, y: 0).frame(maxWidth: 136).padding()
                }
                
                
            }.frame(width: 160, height: 217, alignment: .bottom)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.3),radius: 15, x: 0, y: 10)
                .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden) {
                    
                    
                    Button("Play") {
                        changeIntoPlayView = true
                    }
                    Button("Modify") {
                        
                    }
                }
            
            
            
            
            
            
            
        }
    }
}






