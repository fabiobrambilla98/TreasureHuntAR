//
//  CustomARView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import RealityKit
import ARKit

/*extension ARAnchor {
    struct SelfModelEntity {
        static var _modelEntity: ModelEntity? = nil
    }
    
    struct SelfModelEntities {
        static var _modelEntities: [ModelEntity]? = nil
    }
    
    var modelEntities: [ModelEntity]? {
        get {
            return SelfModelEntities._modelEntities
        }
        set(newValue) {
            SelfModelEntities._modelEntities = newValue
        }
    }
    
    var modelEntity: ModelEntity? {
        get {
            return SelfModelEntity._modelEntity
        }
        set(newValue) {
            SelfModelEntity._modelEntity = newValue
        }
    }
}
*/

enum ARMode {
    case play, create
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
    
    func setup(mode: ARMode) {
        
        if mode == .create {
            self.session.run(defaultConfiguration)
        } else if mode == .play {
            loadSession(number: 0)
        }
        
        self.session.delegate = self
        self.setupGestures()
        
    }
    
    // MARK: - AR content
    
    var actionButtonsAnchorEntity: Entity?
    var tappedObject: Entity?
    
    
    var virtualObjectAnchor: ARAnchor?
    let virtualObjectAnchorName = "virtualObject"
    var sessionModelEntities: [StoreModelEntity] = []
    
    
    //var customPresenter: Presenters?
    // MARK: - AR session management
    var isRelocalizingMap = false
    var tapRecognizer: UITapGestureRecognizer? = nil
 
    // MARK: - Persistence: Saving and Loading
   
    var detectedFeaturePoints: Set<SIMD3<Float>> = []
    let storedData = UserDefaults.standard

    func resetTracking() {
        self.session.run(defaultConfiguration, options: [.resetTracking, .removeExistingAnchors])
        self.isRelocalizingMap = false
        self.virtualObjectAnchor = nil
    }

}

