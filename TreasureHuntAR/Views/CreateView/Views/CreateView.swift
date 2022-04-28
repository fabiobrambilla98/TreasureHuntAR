//
//  CreateView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI
import ARKit
import RealityKit
import Combine


struct CreateView: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            ARViewContainer(presenter: self.presenter).edgesIgnoringSafeArea(.all)
            
            VStack {
                SessionActionView(presenter: self.presenter)
                
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
            
            if(Observed.shared.showPopUp) {
                PopUpWindow(title: Observed.shared.text, buttonText: "asdf", show: true)
            }
        }.edgesIgnoringSafeArea(.all).fullScreen(alignment: .bottom).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(presenter: self.presenter), trailing:
                                    HStack(spacing: 15) {
                Button(action: {}) {
                    Text("Save")
                }
                Button(action: {self.presenter.listSelector(action: .open)}) {
                    Image(systemName: "list.bullet")
                }
            })
    }   
}









