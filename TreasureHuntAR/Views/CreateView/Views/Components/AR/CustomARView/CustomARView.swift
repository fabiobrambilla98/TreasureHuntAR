//
//  CustomARView.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import RealityKit
import ARKit




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
        presenter = (viewPresenter as! CreateViewPresenter)
        self.session.run(defaultConfiguration)
        self.session.delegate = self
        self.setupGestures()
        self.debugOptions = [ ]
    }
    
    // MARK: - AR content
    
    var actionButtonsAnchorEntity: Entity?
    var tappedObject: Entity?
    
    
    var virtualObjectAnchor: ARAnchor?
    let virtualObjectAnchorName = "virtualObject"
   
    
    var presenter: CreateViewPresenter?
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

