//
//  CreateView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI
import ARKit
import UIKit
import RealityKit
import Combine


struct CreateView: View {
    @State var text: String = ""
    @State var showErrorMessage: Bool = false
    @ObservedObject var presenter: CreateViewPresenter
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            ARViewContainer(presenter: self.presenter).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                SessionActionView().environmentObject(self.presenter)
                
                MyItemBar(presenter: self.presenter)
            }
            if(self.presenter.sessionListSelection == .open) {
                SceneListPopup(presenter: self.presenter).edgesIgnoringSafeArea(.all)
            }
            
            if(self.presenter.showParchment) {
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.all)
                ParchmentPopup().environmentObject(presenter).navigationBarHidden(true).onDisappear() {
                    presenter.objectToAdd = nil
                    presenter.parchmentToModify = nil
                }
            }
            
            if(presenter.saveWorldMapPopupShow) {
                SaveMapPopup().environmentObject(presenter)
            }
            
           
            
        }.edgesIgnoringSafeArea(.all).fullScreen(alignment: .bottom).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(presenter: self.presenter), trailing:
                                    HStack(spacing: 15) {
                if(presenter.dataToBeStored.count >= 1 && presenter.treasurePlaced) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            presenter.saveWorldMapPopupShow = true
                        }
                    }) {
                        ZStack {
                            Image(systemName: "tray.and.arrow.down").foregroundColor(Color.white).shadow(radius: 3)
                        }.frame(width: 38, height: 38).background(Color.secondaryColor.opacity(0.7)).cornerRadius(100)
                    }.padding(.top)
                }
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.presenter.listSelector(action: .open)}}) {
                    ZStack {
                        Image(systemName: "list.bullet").foregroundColor(Color.white).shadow(radius: 3)
                    }.frame(width: 38, height: 38).background(Color.secondaryColor.opacity(0.7)).cornerRadius(100)
                }.padding(.top)
            })
        
        
    }
}





struct ARVC: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        return arView
        
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        
    }
    
    
    
}







