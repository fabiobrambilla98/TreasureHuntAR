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
    
    
    // MARK: - AR properties
    var objectToAdd: ObjectEntity?
    var parchmentToModify: Entity?
    @Published var dataToBeStored: [Data] = []
    var currentSession: Int = 0
    @Published var featuresPoints: Int = 0
    
    init(){
        
        self.parchmentImages = self.service.getModelNames(for: ModelTypes.parchment)
        
        self.treasureImages = self.service.getModelNames(for: ModelTypes.treasure)
        
        for name in self.parchmentImages {
            self.lastSelected.append(name.0)
        }
        
        for name in self.treasureImages {
            self.lastSelected.append(name.0)
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
    
    
    
}

