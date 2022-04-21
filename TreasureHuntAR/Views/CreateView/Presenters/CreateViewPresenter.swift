//
//  CreateViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

protocol CreateViewPresenting: ObservableObject {
    var parchementNames: [String] {get}
    
    func saveWorldMap()
    func loadWorldMap()
    func openSheet()
    func selectEntity(_ name: String)
    func showBackAlert()
}

enum ButtonItemsIDs {
    case initialSelect
    case firstIconSelect
    case secondIconSelect
    
}


final class CreateViewPresenter: CreateViewPresenting {
   
    
    private var service = AppService.shared
    
    @Published var parchementNames: [String] = []
    @Published var lastSelected: [String] = []
    @Published var buttonItemsID: ButtonItemsIDs = ButtonItemsIDs.initialSelect
    @Published var showBrowse: Bool = false
    @Published var showAlert: Bool = false
    
    
    init(){
        print("DEBUG: INIT PRESENTER")
        self.parchementNames = self.service.getParchmentNames()
        for name in self.parchementNames {
            self.lastSelected.append(name)
        }
        
    }
    
    func showBackAlert() {
        self.showAlert = true
    }
    
    func selectEntity(_ name: String) {
        self.lastSelected.updateLast(name)
    }
    
    func saveWorldMap() {
        
    }
    
    func loadWorldMap() {
        
    }
    
    func openSheet() {
        
    }
    
   
}

