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




struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}






struct CreateView: View {
    
    @ObservedObject var presenter: CreateViewPresenter
    @State var savedMap: Bool = false
    @State var presentPopUp: Bool = false
    
    var body: some View {
        
        
        ZStack {
            
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack(spacing: 20) {
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            savedMap = true
                        }
                    }) {
                        
                        Text("Save")
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(40)
                    }
                    
                    if(savedMap) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                savedMap = false
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
                
                
                
                MyItemBar(presenter: self.presenter, showBrowse: self.$presenter.showBrowse)
                
            }.edgesIgnoringSafeArea(.all).fullScreen(alignment: .bottom)
            
            if(presentPopUp) {
                SceneListPopup()
            }
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(presenter: self.presenter), trailing:
                                    HStack(spacing: 15) {
                Button(action: {presentPopUp = true}) {
                    Text("Save")
                }
                Button(action: {presentPopUp = true}) {
                    Image(systemName: "list.bullet")
                }
            })
        
        
        
    }
    
    
    
}




struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
