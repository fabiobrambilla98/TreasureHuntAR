//
//  SaveMapPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 29/04/22.
//

import SwiftUI

struct SaveMapPopup: View {
    
    @State var showErrorMessage: Bool = false
    @State var text: String = ""
    @EnvironmentObject var presenter: CreateViewPresenter
    
    var body: some View {
        ZStack{
            ZStack {
                
                VStack {
                    Text("Enter a name for the map").foregroundColor(Color.white).padding(.top)
                    Spacer()
                    if(showErrorMessage) {
                        Text("Nome già utilizzato").foregroundColor(Color.red)
                    }
                    TextField("Map name", text: $text).font(.title2).padding()
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Divider().foregroundColor(Color.white)
                        HStack(alignment: .center) {
                            Spacer()
                            Button(action: {
                                presenter.saveWorldMapPopupShow = false
                            }) {
                                Text("Cancel")
                            }
                            Spacer()
                            Divider().foregroundColor(Color.white)
                            Spacer()
                            Button(action: {
                                if(!presenter.mapAlreadySavedNames.contains(text)) {
                                    presenter.saveWorldMap(text: text)
                                } else {
                                    showErrorMessage = true
                                }
                            }) {
                                Text("Save")
                            }
                            Spacer()
                        }.frame(maxHeight: 45)
                    }
                }
            }.frame(minWidth: 0, maxWidth: 270, minHeight: 0, maxHeight: 200, alignment: .bottom).background(Color(.systemGroupedBackground)).cornerRadius(15)
        }.fullScreen(alignment: .center).background(Color.black.opacity(0.3))
    }
}

struct SaveMapPopup_Previews: PreviewProvider {
    static var previews: some View {
        SaveMapPopup()
    }
}
