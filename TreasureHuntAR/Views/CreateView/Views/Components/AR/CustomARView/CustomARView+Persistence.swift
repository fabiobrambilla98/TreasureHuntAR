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
        if let presenter = viewPresenter as? CreateViewPresenter {
            self.resetTracking()
            presenter.newSessionButtonVisible = false
            presenter.currentSession += 1
        }
    }
    
    
    
    func loadSession(number: Int) {
        
        let worldMap: ARWorldMap = {
            var data: Data? = nil
            if let presenter = viewPresenter as? CreateViewPresenter {
                data = presenter.dataToBeStored[number].sessionWorldMap
            } else if let presenter = viewPresenter as? PlayViewPresenter {
                data = presenter.mapSessions[number].sessionWorldMap
            }
            
            do {
                guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data!)
                else { fatalError("No ARWorldMap in archive.") }
                return worldMap
            } catch {
                fatalError("Can't unarchive ARWorldMap from file data: \(error)")
            }
        }()
        
        
        let configuration = self.defaultConfiguration
        configuration.initialWorldMap = worldMap
        if let presenter = viewPresenter as? CreateViewPresenter {
            virtualObjectAnchor = nil
            presenter.currentSession = number
        } else if let presenter = viewPresenter as? PlayViewPresenter {
            presenter.currentSession = number
            presenter.currentSessionClues = 0
            presenter.sessionClueFound = 0
        }
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        isRelocalizingMap = true
        
        
        
        
    }
    
    func saveSession() {
        if let presenter = viewPresenter as? CreateViewPresenter {
            self.session.getCurrentWorldMap { worldMap, _ in
                guard let map = worldMap else {
                    print("Cannot get current world map");
                    return
                }
                
                for anchorMap in map.anchors {
                    if anchorMap.name == "parchment" || anchorMap.name == "treasure" {
                        for model in self.sessionModelEntities {
                            if model.identifier == anchorMap.identifier {
                                model.transform = anchorMap.transform
                            }
                        }
                        
                    }
                }
                
                
                do {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                    
                    if(presenter.currentSession >= presenter.dataToBeStored.count) {
                        
                        presenter.dataToBeStored.append(SessionData(data: data, modelEntities: self.sessionModelEntities))
                        
                    } else {
                        presenter.dataToBeStored.replace(index: presenter.currentSession, with: SessionData(data: data, modelEntities: self.sessionModelEntities))
                    }
                    
                    if(!presenter.newSessionButtonVisible) {
                        presenter.newSessionButtonVisible = true
                    }
                    
                    
                } catch {
                    fatalError("Can't save map: \(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    
    
}


