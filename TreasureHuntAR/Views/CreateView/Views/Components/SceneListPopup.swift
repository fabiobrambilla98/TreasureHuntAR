//
//  SceneListPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 21/04/22.
//

import SwiftUI

struct SceneListPopup: View {
    @State var showAlert: Bool = false
    @ObservedObject var presenter: CreateViewPresenter
    var body: some View {
        ZStack {
            
            ZStack {
                
                VStack(spacing: 10){
                    Text("Select the scene to load").foregroundColor(Color.white).padding(.top)
                    Divider().foregroundColor(Color.white)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            ForEach(0 ..< presenter.dataToBeStored.count, id: \.self) { index in
                                Button(action: {
                                    self.presenter.loadSession(number: index)
                                }) {
                                    Text("Scena \(index)")
                                    
                                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                            }
                            
                        }
                        
                    }
                    
                    VStack {
                        
                        Divider().foregroundColor(Color.white)
                        Button(action: {
                            self.presenter.listSelector(action: .close)
                        }) {
                            Text("Cancel").font(.title3)
                        }
                            
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 42).padding(.bottom, 5)
                    
                    
                }
            }.frame(minWidth: 0, maxWidth: 270, minHeight: 0, maxHeight: 200, alignment: .bottom)
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
        }.fullScreen(alignment: .center).edgesIgnoringSafeArea(.all).background(Color.black.opacity(0.4))
    }
}


