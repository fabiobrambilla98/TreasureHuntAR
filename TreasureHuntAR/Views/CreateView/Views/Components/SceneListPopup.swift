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
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                
                VStack(spacing: 10){
                    Text("\(presenter.featuresPoints)").foregroundColor(Color.white).padding(.top)
                    Divider().foregroundColor(Color.white)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(0 ..< presenter.dataToBeStored.count, id: \.self) { index in
                                Button(action: {showAlert = true}) {
                                    Text("Scena \(index)").font(Font.custom("treasure", size: 22))
                                    
                                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 40)
                            }
                            
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                    Divider().padding(.bottom, -3.0).foregroundColor(Color.white)
                    Button(action: {
                        self.presenter.listSelector(action: .close)
                    }) {
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


