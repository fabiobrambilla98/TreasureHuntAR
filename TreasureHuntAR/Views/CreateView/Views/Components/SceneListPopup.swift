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
            ZStack {
                
                VStack(spacing: 10){
                    Text(LocalizedStringKey("select-session-to-load")).foregroundColor(Color.white).shadow(radius: 3).padding(.top)
                    Divider().foregroundColor(Color.white)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            ForEach(0 ..< presenter.dataToBeStored.count, id: \.self) { index in
                                Button(action: {
                                    self.presenter.loadSession(number: index)
                                }) {
                                    let scene = LocalizedStringKey("scene")
                                    HStack{
                                        Text(scene)
                                        Text("\(index)")
                                    }.foregroundColor(Color.white).shadow(radius: 3)
    
                                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                            }
                            
                        }
                        
                    }
                    
                    VStack {
                        
                        Divider().foregroundColor(Color.white)
                        Button(action: {
                            self.presenter.listSelector(action: .close)
                        }) {
                            Text(LocalizedStringKey("cancel")).font(.title3).foregroundColor(Color.white).shadow(radius: 3)
                        }
                            
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 42).padding(.bottom, 5)
                    
                    
                }
            }.frame(minWidth: 0, maxWidth: 270, minHeight: 0, maxHeight: 200)
                    .background(Color.secondaryColor.opacity(0.9))
                .cornerRadius(20)
            }.frame(minWidth: 0, maxWidth: 275, minHeight: 0, maxHeight: 205)
                .background(Color.thirdColor.opacity(0.9))
                .cornerRadius(20)
        }.fullScreen(alignment: .center).edgesIgnoringSafeArea(.all).background(Color.black.opacity(0.4))
    }
}


