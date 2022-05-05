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


final class CreateViewPresenter: Presenters, CreateViewPresenting {
   
    private var service = AppService.shared
    
    var parchmentImages: [(String, UIImage)] = []
    var treasureImages: [(String, UIImage)] = []
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
    @Published var loadSessionPressed: (Bool, Int) = (false, 0)
    
    
    // MARK: - Save world map properties
    @Published var saveWorldMapPopupShow: Bool = false
    var mapAlreadySavedNames: [String] = []
    
    // MARK: - UI properties
    @Published var saveButtonEnabled: Bool = false
    @Published var newSessionButtonVisible: Bool = false
    
    // MARK: - AR properties
    var objectToAdd: ObjectEntity?
    var parchmentToModify: Entity?
    @Published var dataToBeStored: [SessionData] = []
    var currentSession: Int = 0
    
    
    override init(){
        
        super.init()
        
        self.parchmentImages = self.service.getModelNames(for: ModelTypes.parchment)
        
        self.treasureImages = self.service.getModelNames(for: ModelTypes.treasure)
        
        for name in self.parchmentImages {
            self.lastSelected.append(name.0)
        }
        
        for name in self.treasureImages {
            self.lastSelected.append(name.0)
        }
        
        self.mapAlreadySavedNames = self.service.getAllStoredMapNames()
        
    }
    
    func showBackAlert() {
        self.showAlert = true
    }
    
    func selectEntity(_ name: String) {
        self.lastSelected.updateLast(name)
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
        if(name.hasPrefix("p_")) {
            self.objectToAdd = ParchmentEntity(modelName: name) }
        else if(name.hasPrefix("c_")) {
            //size in m
            self.objectToAdd = TreasureEntity(modelName: name, width: 0.5, height: 0.4, depth: 0.4)
        }
    }
    
    func deselectEntityToAdd() {
        self.objectToAdd = nil
    }
    
    func addTextToParchment(_ text: String) {
        self.parchmentText = text
        self.addingParchmentText = true
    }
    
    func saveSession() {
        self.saveSessionButtonPressed = true
    }
    
    func loadSession(number: Int) {
        self.loadSessionPressed = (true, number)
        self.sessionListSelection = .close
        if(!self.newSessionButtonVisible) {
            self.newSessionButtonVisible = true
        }
    }
    
    func newSession() {
        self.newSessionButtonPressed = true
    }
    
    func saveWorldMap(text: String) {
        service.saveWorldMapPersistence(map: dataToBeStored, named: text)
        self.saveWorldMapPopupShow = false
    }
}

