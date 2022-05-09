//
//  CreateViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI
import CoreLocation
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
    var parchmentToModify: CustomModelEntity?
    @Published var dataToBeStored: [SessionData] = []
    var currentSession: Int = 0
    
    private var _startLocation: CLLocation? = nil
    private let locationManager = CLLocationManager()
    var startingPointCapturedImage: Data? = nil
    var caputureImage: Bool = false
    
    
    override init() {
        
        super.init()
        
        DispatchQueue.main.async { [weak self] in
            self!.parchmentImages = self!.getModelsImages(for: .parchment)
            
            for name in self!.parchmentImages {
                self!.lastSelected.append(name.0)
            }
            
            self!.treasureImages =  self!.getModelsImages(for: .treasure)
            
            for name in self!.treasureImages {
                self!.lastSelected.append(name.0)
            }
            
            self!.mapAlreadySavedNames = self!.service.getAllStoredMapNames()
        }
       
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func getModelsImages(for type: ModelTypes)  -> [(String, UIImage)] {
        switch(type) {
        case .parchment:
            return self.service.getModelNames(for: type)
        case .treasure:
            return self.service.getModelNames(for: type)
            
        }
   
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
        if(currentSession == 0) {
            caputureImage = true
            guard let location = locationManager.location else {return}
            _startLocation = location
        }
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
        service.saveStartLocationImage(image: startingPointCapturedImage!, mapName: text)
        service.saveLocation(location: _startLocation!, name: text)
        service.saveWorldMapPersistence(map: dataToBeStored, named: text)
        self.saveWorldMapPopupShow = false
    }
}

