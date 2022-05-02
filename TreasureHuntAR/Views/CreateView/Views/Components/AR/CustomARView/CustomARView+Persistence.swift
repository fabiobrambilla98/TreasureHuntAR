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
    
    func newSession() {
        self.resetTracking()
        self.presenter!.newSessionButtonVisible = false
        self.presenter!.currentSession += 1
    }
    
    func loadSession(number: Int) {
        
        /// - Tag: ReadWorldMap
        let worldMap: ARWorldMap = {
            let data = self.presenter!.dataToBeStored[number]
            
            do {
                guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)
                else { fatalError("No ARWorldMap in archive.") }
                return worldMap
            } catch {
                fatalError("Can't unarchive ARWorldMap from file data: \(error)")
            }
        }()
        
        let configuration = self.defaultConfiguration
        configuration.initialWorldMap = worldMap
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        isRelocalizingMap = true
        virtualObjectAnchor = nil
        self.presenter!.currentSession = number
        
        
    }
    
    func saveSession() {
        self.session.getCurrentWorldMap { [self] worldMap, _ in
            guard let map = worldMap else {
                print("Cannot get current world map");
                return
            }
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                
                if(self.presenter!.currentSession >= self.presenter!.dataToBeStored.count) {
                    self.presenter!.dataToBeStored.append(data)
                    
                } else {
                    self.presenter!.dataToBeStored.replace(index: self.presenter!.currentSession, with: data)
                }
                
                if(!self.presenter!.newSessionButtonVisible) {
                    self.presenter!.newSessionButtonVisible = true
                }
                
                
            } catch {
                fatalError("Can't save map: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}


