//
//  CustomARView+Persistence.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

extension CustomARView {
    // MARK: - Persistence: Saving and Loading
    
    func loadExperience(number: Int) {
        
        /// - Tag: ReadWorldMap
        let worldMap: ARWorldMap = {
            guard let data = self.getWorldMapData(pos: number)
                else { fatalError("Map data should already be verified to exist before Load button is enabled.") }
            do {
                guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)
                    else { fatalError("No ARWorldMap in archive.") }
                return worldMap
            } catch {
                fatalError("Can't unarchive ARWorldMap from file data: \(error)")
            }
        }()

        
       

        let configuration = self.defaultConfiguration // this app's standard world tracking settings
        configuration.initialWorldMap = worldMap
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        isRelocalizingMap = true
        virtualObjectAnchor = nil
        virtualObjectNumber = 0
        self.currentMapNumber = number
        
        Observed.shared.showPopUp(text: "\(String(self.mapKeys.count)) \(self.currentMapNumber)")
        if(self.mapKeys.count > currentMapNumber + 1) {
            Observed.shared.loadNextMapEnabled = true
        }
    }
    
    func saveExperience() {
        self.session.getCurrentWorldMap { worldMap, _ in
            guard let map = worldMap else {
                print("Cannot get current world map");
                return
            }
          
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                
                if(!self.mapKeys.contains("\(self.mapKey)\(self.currentMapNumber)")) {
                    self.mapKeys.append("\(self.mapKey)\(self.currentMapNumber)")
                    self.storedData.set(self.mapKeys, forKey: "mapKeys")
                    self.storedData.synchronize()
                }
                

                if self.getWorldMapData(pos: self.currentMapNumber) != nil {
                    self.storedData.setValue(data, forKey: "\(self.mapKey)\(self.currentMapNumber)")
                } else {
                    self.storedData.set(data, forKey: "\(self.mapKey)\(self.currentMapNumber)")
                }
                
              
                self.currentMapNumber += 1
                
                
                if(self.mapKeys.count > 1) {
                    Observed.shared.loadNextMapEnabled = true
                }
               
                Observed.shared.loadMapEnabled = true
            } catch {
                fatalError("Can't save map: \(error.localizedDescription)")
            }
        }
    }
    
}

