//
//  AppService.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import Foundation
import UIKit
import CoreLocation

enum ModelTypes: Codable {
    case parchment, treasure
}

protocol AppServiceProtocol {
    func getModelNames(for type: ModelTypes) -> [(String, UIImage)]
    
}

final class AppService: AppServiceProtocol {
    static let shared = AppService()
    var repository: Repository? = nil
    let fileManager = FileManager.default
    let storedData = UserDefaults.standard
    
    init(){
        self.repository = Repository()
    }
    
    func getModelNames(for type: ModelTypes) -> [(String, UIImage)] {
        
        if(repository!.parchmentNames == nil || repository!.treasureNames == nil) {
            
            if(repository!.parchmentNames == nil && type == .parchment) {
                repository!.parchmentNames = []
            } else if(repository!.treasureNames == nil && type == .treasure) {
                repository!.treasureNames = []
            }
            
            
            guard let path = Bundle.main.resourcePath, let files = try? fileManager.contentsOfDirectory(atPath: path) else {
                return []
            }
            
            
            for fileName in files where
            fileName.hasSuffix("png") && fileName.hasPrefix((type == .parchment) ? "p_" : "c_") {
                let modelName = fileName.replacingOccurrences(of: ".png", with: "")
                if(type == .parchment) {
                    repository!.parchmentNames?.append((modelName, UIImage(named: modelName)!))
                } else {
                    repository!.treasureNames?.append((modelName, UIImage(named: modelName)!))
                }
                
            }
            
            
            if(type == .parchment) {
                return repository!.parchmentNames!
            } else {
                return repository!.treasureNames!
            }
            
            
        }
        
        if(type == .parchment) {
            return repository!.parchmentNames!
        } else {
            return repository!.treasureNames!
        }
    }
    
    func saveWorldMapPersistence(map: [SessionData], named name: String, overwrite: Bool = false){
        
        if(!overwrite) {
            let data = map.map({$0.serializeObject()})
            self.storedData.set(data, forKey: "m_\(name)")
            self.storedData.synchronize()
            
            
        } else {
            self.storedData.setValue(map, forKey: "m_\(name)")
            self.storedData.synchronize()
        }
        
    }
    
    func getAllStoredMapNames() -> [String] {
        return Array(UserDefaults.standard.dictionaryRepresentation().keys).filter({$0.hasPrefix("m_")}).map({$0.replacingOccurrences(of: "m_", with: "")})
    }
    
    func saveStartLocationImage(image: Data, mapName: String) {
        UserDefaults.standard.set(image, forKey: "img_\(mapName)")
    }
    
    func deleteMap(mapName: String) {
        UserDefaults.standard.removeObject(forKey: "m_\(mapName)")
        UserDefaults.standard.removeObject(forKey: "img_\(mapName)")
        UserDefaults.standard.removeObject(forKey: "l_\(mapName)")
    }
    
    func getStartAllStartLocationImage(mapNames: [String]) -> [(String, UIImage)] {
        var returnArray: [(String, UIImage)] = []
        for name in mapNames {
            if let imageData = UserDefaults.standard.object(forKey: "img_\(name)") as? Data,
               let image = UIImage(data: imageData) {
                returnArray.append((name, image.rotate(radians: 90 * .pi/180)!))
        }
    
        }
        
        return returnArray
    }
    
    func getStartLocationImage(mapName: String) -> UIImage {
        
        if let imageData = UserDefaults.standard.object(forKey: "img_\(mapName)") as? Data,
           let image = UIImage(data: imageData) {
            
            return image
        }
        fatalError()
    }
    
    
    func saveLocation(location: CLLocation, name: String) {
        if let encodedLocation = try? NSKeyedArchiver.archivedData(withRootObject: location, requiringSecureCoding: false) {
            UserDefaults.standard.set(encodedLocation, forKey: "l_\(name)")
        }
    }
    
    func getStartLocation(name: String) -> CLLocation {
        if let loadedLocation = UserDefaults.standard.data(forKey: "l_\(name)"),
           let decodedLocation = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(loadedLocation) as? CLLocation {
            return decodedLocation
        } else {
            fatalError()
        }
    }
    
    func getMap(_ name: String) -> [SessionData]{
        do {
            
            let data: [Data] = (self.storedData.array(forKey: "m_\(name)") as? [Data])!
            
            let returnedData = try data.map({try JSONDecoder().decode(SessionData.self, from: $0)})
            
            return returnedData
            
        }  catch {
            fatalError("Can't unarchive ARWorldMap from file data: \(error)")
        }
        
    }
    
}
