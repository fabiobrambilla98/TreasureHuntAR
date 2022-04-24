//
//  CreateViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI
import Combine
import RealityKit

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

enum ShowAction {
    case open
    case close
}


final class CreateViewPresenter: CreateViewPresenting {
    
    
    private var service = AppService.shared
    
    @Published var parchementNames: [String] = []
    @Published var lastSelected: [String] = []
    @Published var buttonItemsID: ButtonItemsIDs = ButtonItemsIDs.initialSelect
    @Published var showBrowse: Bool = false
    @Published var showAlert: Bool = false
    @Published var saveSessionButtonPressed: Bool = false
    @Published var newSessionButtonPressed: Bool = false
    @Published var sessionListSelection: ShowAction = .close
    @Published var showParchment: Bool = false
    var parchmentText: String = ""
    @Published var addingParchmentText: Bool = false
    
    
    // MARK: - AR properties
   
    var objectToAdd: ObjectEntity?
    var parchmentToModify: Entity?
    
    
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
        self.saveSessionButtonPressed = true
    }
    
    func loadWorldMap() {
        
    }
    
    func listSelector(action: ShowAction) {
        self.sessionListSelection = action
    }
    
    func openSheet() {
        self.showBrowse = true
    }
    func closeSheet() {
        self.showBrowse = false
    }
    
    func selectEntityToAdd(name: String) {
        self.objectToAdd = ParchmentEntity(modelName: name)
    }
    
    func deselectEntityToAdd() {
        self.objectToAdd = nil
    }
    
    func addTextToParchment(_ text: String) {
        self.parchmentText = text
        self.addingParchmentText = true
    }
    
    
    
}

