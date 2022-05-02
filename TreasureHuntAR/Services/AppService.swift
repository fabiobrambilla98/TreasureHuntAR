//
//  AppService.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import Foundation
import UIKit

enum ModelTypes {
    case parchment, treasure
}

protocol AppServiceProtocol {
    func getModelNames(for type: ModelTypes) -> [(String, UIImage)]
    
}

final class AppService: AppServiceProtocol {
    static let shared = AppService()
    var repository = Repository()
    let fileManager = FileManager.default
    let storedData = UserDefaults.standard
    
    private init(){}
    
    func getModelNames(for type: ModelTypes) -> [(String, UIImage)] {
        if(repository.parchmentNames == nil || repository.treasureNames == nil) {
            
            if(repository.parchmentNames == nil && type == .parchment) {
                repository.parchmentNames = []
            } else if(repository.treasureNames == nil && type == .treasure) {
                repository.treasureNames = []
            }
            
            
            guard let path = Bundle.main.resourcePath, let files = try? fileManager.contentsOfDirectory(atPath: path) else {
                return []
            }
            
            
            for fileName in files where
            fileName.hasSuffix("png") && fileName.hasPrefix((type == .parchment) ? "p_" : "c_") {
                let modelName = fileName.replacingOccurrences(of: ".png", with: "")
                if(type == .parchment) {
                    repository.parchmentNames?.append((modelName, UIImage(named: modelName)!))
                } else {
                    repository.treasureNames?.append((modelName, UIImage(named: modelName)!))
                }
                
            }
            
            
            if(type == .parchment) {
                return repository.parchmentNames!
            } else {
                return repository.treasureNames!
            }
            
            
        }
        
        if(type == .parchment) {
            return repository.parchmentNames!
        } else {
            return repository.treasureNames!
        }
    }
    
    func saveWorldMapPersistence(map: [Data], named name: String, overwrite: Bool = false){
        
        if(!overwrite) {
            self.storedData.set(map, forKey: "m_\(name)")
            self.storedData.synchronize()
        } else {
            self.storedData.setValue(map, forKey: "m_\(name)")
            self.storedData.synchronize()
        }
        
    }
    
    func getAllStoredMapNames() -> [String] {
        return Array(UserDefaults.standard.dictionaryRepresentation().keys).filter({$0.hasPrefix("m_")}).map({$0.replacingOccurrences(of: "m_", with: "")})
    }
    
}
