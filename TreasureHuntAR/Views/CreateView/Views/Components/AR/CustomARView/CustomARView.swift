//
//  CustomARView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import RealityKit
import ARKit

//This struct is used for manage the actions entity for the parchments and treasures both
struct ActionEntityStruct{
    var modelEntities: [Entity]?
    var anchorEntity: AnchorEntity?
    
    init() {
        self.modelEntities = nil
        self.anchorEntity = nil
    }
}


struct OOPresenter {
    @ObservedObject var presenter: CreateViewPresenter
}



class CustomARView: ARView {
   
    var defaultConfiguration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
        }
        return configuration
    }
    // MARK: - Init and setup
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
       
    }

    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 

    func setup() {
        self.session.run(defaultConfiguration)
        self.session.delegate = self
        self.setupGestures()
        self.debugOptions = [ ]
    }
    
    // MARK: - AR content
    
    var presenter: OOPresenter!
    var actionButtonsAnchorEntity: Entity?
    var tappedObject: Entity?
    
    
    var virtualObjectAnchor: ARAnchor?
    let virtualObjectAnchorName = "virtualObject"
    var virtualObjectNumber: Int = 0
    
    
    // MARK: - AR session management
    var isRelocalizingMap = false
    
 
    // MARK: - Persistence: Saving and Loading
   
    var aviator: Set<SIMD3<Float>> = []
    let storedData = UserDefaults.standard
    var mapKeys: [String] = []
    let mapKey = "ar.worldmap"
    var currentMapNumber = 0

    var worldMapKeys: [String]? {
        get {
            return storedData.stringArray(forKey: "mapKeys")
        }
        
    }
    
    func resetTracking() {
        self.session.run(defaultConfiguration, options: [.resetTracking, .removeExistingAnchors])
        self.isRelocalizingMap = false
        self.virtualObjectAnchor = nil
        self.virtualObjectNumber = 0
        self.currentMapNumber = 0
        self.mapKeys = []
    }
    
    func getWorldMapData(pos: Int) -> Data? {
        guard let mapk = worldMapKeys else {
            return nil
        }
        
        return storedData.data(forKey: mapk[pos])
    }
}

