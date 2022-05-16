//
//  CustomARView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import RealityKit
import ARKit


enum ARMode {
    case play, create
}

class CustomARView: ARView {
    
    enum PresenterType {
        case play, create
    }
    
    deinit {
        print("DEINIT: CustomARView")
    }
   
    // MARK: - DEFAULT CONFIGURATION
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
    
    // MARK: - SETUP
    func setup(mode: ARMode) {
        
        if mode == .create {
            self.session.run(defaultConfiguration)
            presenterType = .create
            createViewPresenter = (self.viewPresenter as! CreateViewPresenter)
        } else if mode == .play {
            loadSession(number: 0)
            presenterType = .play
        }
        
        self.session.delegate = self
        self.setupGestures()
        
    }
    
    // MARK: - AR content
    var actionButtonsAnchorEntity: Entity?
    var tappedObject: CustomModelEntity?
    var presenterType: PresenterType?
    var createViewPresenter: CreateViewPresenter?
    
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
        print("Tracking reset")
        self.session.run(defaultConfiguration, options: [.resetTracking, .removeExistingAnchors])
        self.isRelocalizingMap = false
        self.virtualObjectAnchor = nil
    }

}

