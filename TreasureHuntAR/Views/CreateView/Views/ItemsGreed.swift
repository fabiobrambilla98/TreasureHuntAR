//
//  ItemsGreed.swift
//  Esercitazione1
//
//  Created by MacBook on 18/04/22.
//

import SwiftUI


extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}



struct ItemsGreed: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Indizi")
                ScrollView(.horizontal){
                    HStack{
                        Button(action: {}) {
                            Image("pergamena_4").resizable().frame(width: 100, height: 100)
                        }
                        Button(action: {}) {
                            Image("pergamena_4").resizable().frame(width: 100, height: 100)
                        }
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("Tesori")
                ScrollView(.horizontal){
                    HStack{
                        Button(action: {}) {
                            Image("forziere").resizable().frame(width: 100, height: 100)
                        }
                        Button(action: {}) {
                            Image("forziere").resizable().frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
    }
}


struct BrowseView: View {
    @Binding var showBrowse: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ItemsGreed(showBrowse: $showBrowse)
            }.navigationBarTitle(Text("Items"), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.showBrowse.toggle()
                }) {
                    Text("close").bold()
                })
        }
    }
}

