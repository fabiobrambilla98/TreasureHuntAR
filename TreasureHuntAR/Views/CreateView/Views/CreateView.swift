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
    @State var showDropDown: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //go back <---
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //self.presentationMode.wrappedValue.dismiss()
   
    
    
    
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
                
            }.edgesIgnoringSafeArea(.all).frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .bottom
                )
            
            ZStack{
                
                VStack {
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.2)) {
                            self.presentationMode.wrappedValue.dismiss()
                            showDropDown.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal.circle.fill").resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.blue)
                            .background(Color.white)
                            .clipShape(Circle())
                        
                    }.buttonStyle(PlainButtonStyle())
                        .padding(.top)
                    
                    
                    ScrollView(.vertical) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .opacity(0.7)
                                .frame(width: .infinity, height: .infinity)
                            VStack(spacing: 20) {
                                Button(action: {}) {
                                    Text("session 1")
                                }.buttonStyle(PlainButtonStyle())
                                Button(action: {}) {
                                    Text("session 2")
                                }.buttonStyle(PlainButtonStyle())
                                Button(action: {}) {
                                    Text("session 3")
                                }.buttonStyle(PlainButtonStyle())
                                Button(action: {}) {
                                    Text("session 4")
                                }.buttonStyle(PlainButtonStyle())
                                Button(action: {}) {
                                    Text("session 5")
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(.top)
                        }
                        
                    }.frame(width: 100, height: 150)
                        .cornerRadius(10)
                        .animation(Animation.linear)
                        .scaleEffect(showDropDown ? 1 : 0, anchor: .top)
                        .padding(.trailing, 10)
                    
                    
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topTrailing
                )
                
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topTrailing
            )
            
            
         
        }.navigationBarHidden(true)
            
       
    
    }
    
    struct ARViewContainer: UIViewRepresentable {
    
        func makeUIView(context: Context) -> ARView {
            
            let arView = ARView(frame: .zero)
            
            
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
    }
    
}




