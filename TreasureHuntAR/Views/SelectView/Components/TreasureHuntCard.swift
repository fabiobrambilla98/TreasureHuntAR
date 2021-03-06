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
    @State var changeIntoPlayView: Bool? = nil
    @State var showAlert = false
    
    var body: some View {
        
        Button(action: {
            withAnimation(.easeIn) {
                self.showingOptions = true
            }
        }) {
            ZStack(alignment: .bottom){
                if let image = presenter.cardImages.first(where: {$0.0 == name}) {
                    Image(uiImage: image.1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Text(name).font(.headline).foregroundColor(.white)
                        .shadow(color: .black, radius: 3, x: 0, y: 0).frame(maxWidth: 136).padding()
                } else {
                    ProgressView()
                }
               
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text(LocalizedStringKey("confirm-map-cancel")),
                primaryButton:
                        .destructive(Text(LocalizedStringKey("delete"))) {
                            withAnimation {
                                presenter.deleteMap(mapName: name)
                            }
                    
                        },
                secondaryButton: .cancel()
            )
        }
        .navigate(using: $changeIntoPlayView, destination: makeDestination)
            .frame(width: 160, height: 217, alignment: .bottom)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3),radius: 15, x: 0, y: 10)
            .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden) {
                
                
                Button(LocalizedStringKey("play")) {
                    changeIntoPlayView = true
                }
                Button(
                    role: .destructive,
                    action: {
                        showAlert = true
                    }
                ) {
                    HStack {
                        Image(systemName: "trash")
                        Text(LocalizedStringKey("delete"))
                        
                    }
                }
                
            } 
    }
    
    @ViewBuilder
    private func makeDestination(for isActivate: Bool) -> some View {
        AnyView(PlayView(presenter: PlayViewPresenter(mapName: name)))
    }
}






