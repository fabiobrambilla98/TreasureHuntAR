//
//  TreasureFoundPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 10/05/22.
//

import SwiftUI

struct TreasureFoundPopup: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            ZStack{
                ZStack {
                    Image(uiImage: UIImage(named: "treasure_found_background")!).centerCropped()
                    
                    ZStack(alignment: .bottom) {
                        ZStack(alignment: .top) {
                            VStack(spacing: 10) {
                                Image(uiImage: UIImage(named: "treasure_text_en")!).resizable().scaledToFit()
                                Image(uiImage: UIImage(named: "found_text_en")!).resizable().scaledToFit()
                            }
                        }.fullScreen(alignment: .top).padding()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        } ) {
                            Text("Back")
                                .font(.title)
                        }.frame(minWidth: 0, maxWidth: 90)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("dark_green"), Color("light_green")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                    }.padding()
                }.fullScreen(alignment: .center).cornerRadius(20).padding()
                
                
                
            }.frame(width: 300, height: 400)
        }.fullScreen(alignment: .center).background(Color.black.opacity(0.5)).edgesIgnoringSafeArea(.all)
    }
}


