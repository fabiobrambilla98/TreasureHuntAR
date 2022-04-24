//
//  AppService.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import Foundation

protocol AppServiceProtocol {
    func getParchmentNames() -> [String]
}

final class AppService: AppServiceProtocol {
    static let shared = AppService()
    var repository = Repository()
    let fileManager = FileManager.default
    
    private init(){}
    
    
    func getParchmentNames() -> [String] {
        if(repository.parchmentNames == nil) {
            repository.parchmentNames = []
            
            
            guard let path = Bundle.main.resourcePath, let files = try? fileManager.contentsOfDirectory(atPath: path) else {
                return []
            }
            
            for fileName in files where
            fileName.hasSuffix("png") && fileName.hasPrefix("p_") {
                let modelName = fileName.replacingOccurrences(of: ".png", with: "")
                    repository.parchmentNames?.append(modelName)
              
            }
          
          
            return repository.parchmentNames!

        }
        
        return repository.parchmentNames!
    }
    
    
}
