//
//  SelectViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 02/05/22.
//

import SwiftUI




final class SelectViewPresenter: ObservableObject {
   
    
    private var service: AppService = AppService.shared
    @Published var treasureHuntListNames: [String] = []
    @Published var cardImages: [(String, UIImage)] = []
    
    deinit {
        print("DEINIT: SelectViewPresenter")
    }
    
    init() {
        self.treasureHuntListNames = self.service.getAllStoredMapNames()
        DispatchQueue.main.async { [weak self] in
            self!.cardImages = self!.service.getStartAllStartLocationImage(mapNames: self!.treasureHuntListNames)
        }
    }
    
    func getImage(named name: String) -> UIImage {
        
        return service.getStartLocationImage(mapName: name).rotate(radians: 90 * .pi/180)!
    }
    
    func deleteMap(mapName: String) {
        service.deleteMap(mapName: mapName)
        treasureHuntListNames.remove(mapName)
        cardImages.remove(mapName)        
    }
    
}
