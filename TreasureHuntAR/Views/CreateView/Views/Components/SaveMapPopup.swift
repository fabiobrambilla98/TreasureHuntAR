//
//  SaveMapPopup.swift
//  TreasureHuntAR
//
//  Created by MacBook on 29/04/22.
//

import SwiftUI

struct SaveMapPopup: View {
    
    enum Actions {
        case cancel, confirm
    }
    
    @State var showErrorMessage: Bool = false
    @State var text: String = ""
    @EnvironmentObject var presenter: CreateViewPresenter
    @State var action: Actions = .cancel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            ZStack {
            ZStack {
                
                VStack {
                    Text(LocalizedStringKey("e-n-m")).foregroundColor(Color.white).shadow(radius: 3).padding(5).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    if(showErrorMessage) {
                        Text(LocalizedStringKey("name-a-u")).foregroundColor(Color.red).shadow(radius: 3).padding()
                    }
                    
                    TextField(LocalizedStringKey("map-name"), text: $text).font(.title2).padding()
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Divider().foregroundColor(Color.white)
                        HStack(alignment: .center) {
                            Spacer()
                            Button(action: {
                                presenter.saveWorldMapPopupShow = false
                               
                            }) {
                                Text(LocalizedStringKey("cancel")).shadow(radius: 3)
                            }
                            Spacer()
                            Divider().foregroundColor(Color.white)
                            Spacer()
                            Button(action: {
                                if(!presenter.mapAlreadySavedNames.contains(text)) {
                                    action = .confirm
                                    presenter.saveWorldMap(text: text)
                                } else {
                                    showErrorMessage = true
                                }
                            }) {
                                Text(LocalizedStringKey("save")).shadow(radius: 3)
                            }
                            Spacer()
                        }.frame(maxHeight: 45).foregroundColor(Color.white)
                    }
                }
            }.frame(minWidth: 0, maxWidth: 270, minHeight: 0, maxHeight: 200).background(Color.secondaryColor.opacity(0.9)).cornerRadius(15)
            }.frame(minWidth: 0, maxWidth: 275, minHeight: 0, maxHeight: 205).background(Color.thirdColor.opacity(0.9)).cornerRadius(15)
        }.fullScreen(alignment: .center).background(Color.black.opacity(0.3)).onDisappear(){
            if(action == .confirm) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SaveMapPopup_Previews: PreviewProvider {
    static var previews: some View {
        SaveMapPopup()
    }
}
