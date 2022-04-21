//
//  SceneListPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 21/04/22.
//

import SwiftUI

struct SceneListPopup: View {
    @State var showAlert: Bool = false
    var body: some View {
        ZStack {
            
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                
                VStack(spacing: 10){
                    Text("Select the scene to load").foregroundColor(Color.white).padding(.top)
                    Divider().foregroundColor(Color.white)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            Button(action: {showAlert = true}) {
                                Text("Scena 1").font(Font.custom("treasure", size: 22))
                                
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 40)
                            
                            Button(action: {showAlert = true}) {
                                Text("Scena 2").font(Font.custom("treasure", size: 22))
                                
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 40)
                            
                            Button(action: {showAlert = true}) {
                                Text("Scena 3").font(Font.custom("treasure", size: 22))
                                
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 40)
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                    Divider().padding(.bottom, -3.0).foregroundColor(Color.white)
                    Button(action: {}) {
                        Text("Cancel").font(Font.custom("treasure", size: 27))
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 42)
                    
                }
            }.frame(minWidth: 0, maxWidth: 270, minHeight: 0, maxHeight: 200, alignment: .bottom)
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
                .padding(.bottom, -5)
        }.fullScreen(alignment: .center).edgesIgnoringSafeArea(.all)
    }
}

struct SceneListPopup_Previews: PreviewProvider {
    static var previews: some View {
        SceneListPopup()
    }
}
