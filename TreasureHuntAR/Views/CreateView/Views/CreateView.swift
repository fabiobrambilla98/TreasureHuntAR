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
    
    @ObservedObject var presenter: CreateViewPresenter
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            ARViewContainer(presenter: self.presenter).edgesIgnoringSafeArea(.all)
            
            VStack {
                SessionActionView().environmentObject(self.presenter)
                
                MyItemBar(presenter: self.presenter)
            }
            if(self.presenter.sessionListSelection == .open) {
                SceneListPopup(presenter: self.presenter)
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
                Button(action: {
                    withAnimation(.easeInOut) {
                        presenter.saveWorldMapPopupShow = true
                    }
                }) {
                    Text("Save")
                }
                Button(action: {self.presenter.listSelector(action: .open)}) {
                    Image(systemName: "list.bullet")
                }
            })
            
    }
}









