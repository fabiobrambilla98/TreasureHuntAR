//
//  PlayViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI


protocol PlayViewPresenting: ObservableObject, Identifiable {
    
}


final class PlayViewPresenter: Presenters, PlayViewPresenting {
    
    private var service: AppService = AppService.shared
    @Published var showParchmentSheet: Bool = false
    var parchmentsFound: [(ParchmentEntity, String)] = []
    var mapName: String = ""
    var mapSessions: [SessionData] = []
    var currentSession: Int = 0
    @Published var clueFound = 0
    var parchmentImages: [(String, UIImage)] = []
    
    init(mapName: String) {
        super.init()
        self.mapName = mapName
        mapSessions = service.getMap(mapName)
        print("KKK: \(mapSessions.count)")
        
        parchmentImages = self.service.getModelNames(for: ModelTypes.parchment)
    }
    
    func getImage(named name: String) -> Image {
        return Image(uiImage: parchmentImages.first(where: {$0.0 == name})!.1)
    }

}
