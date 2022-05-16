//
//  PlayViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI
import CoreLocation

protocol PlayViewPresenting: ObservableObject, Identifiable {
    
}


final class PlayViewPresenter: Presenters, PlayViewPresenting {
    
    deinit {
       print("DEINIT: PlayViewPresenter")
    }
    
    private var service: AppService = AppService.shared
    @Published var showParchmentSheet: Bool = false
    var parchmentsFound: [(ParchmentEntity, String)] = []
    var mapName: String = ""
    var mapSessions: [SessionData] = []
    var currentSession: Int = 0
    var parchmentImages: [(String, UIImage)] = []
    @Published var showParchment: Bool = false
    var parchmentSheetSelected: (ParchmentEntity, String)? = nil
    @Published var showPreviousButton: Bool = false
    @Published var showNextButton: Bool = false
    @Published var sessionClueFound = 0
    @Published var currentSessionClues = 0
    @Published var nextSessionButtonPressed = (false, 0)
    @Published var showMapSheet = false
    @Published var treasureFound = false
    var startLocation: CLLocation?
    var startLocationImage: UIImage?
    
    
    init(mapName: String) {
        super.init()
        self.mapName = mapName
        print("Loading map session")
        mapSessions = service.getMap(mapName)
        print("Map session loaded")
        parchmentImages = self.service.getModelNames(for: ModelTypes.parchment)
        startLocation = service.getStartLocation(name: mapName)
        startLocationImage = service.getStartLocationImage(mapName: mapName)
    
    }
    
    func getImage(named name: String) -> Image {
        
        return Image(uiImage: parchmentImages.first(where: {$0.0 == name})!.1)
    }
    
    
    func loadNextSession() {
        nextSessionButtonPressed = (true, currentSession + 1)
    }
    
   

}
