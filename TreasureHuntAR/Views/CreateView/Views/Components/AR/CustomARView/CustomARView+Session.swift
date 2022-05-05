//
//  CustomARView+Session.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import Foundation
import RealityKit
import ARKit
import SwiftUI


extension CustomARView: ARSessionDelegate {
    
    // MARK: - AR session delegate
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
    }
    
    // This is where we render virtual contents to scene.
    // We add an anchor in `handleTap` function, it will then call this function.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            
            addAnchorEntityToScene(anchor: anchor)
            
        }
    }
    
    /// - Tag: CheckMappingStatus
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if let presenter = viewPresenter as? CreateViewPresenter {
            switch frame.worldMappingStatus {
            case .extending, .mapped:
                if(detectedFeaturePoints.count >= 0) {
                    presenter.saveButtonEnabled = true
                } else if(detectedFeaturePoints.count > 0 && presenter.saveButtonEnabled){
                    presenter.saveButtonEnabled = false
                }
            default:
                if(presenter.saveButtonEnabled) {
                    presenter.saveButtonEnabled = false
                }
                
                
            }
            
            if(actionButtonsAnchorEntity != nil) {
                actionButtonsAnchorEntity!.billboard(targetPosition: self.cameraTransform.translation)
                
            }
            
            /*guard (frame.rawFeaturePoints != nil) else {
             return
             }
             
             for item in frame.rawFeaturePoints!.points {
             if(!detectedFeaturePoints.contains(item)) {
             detectedFeaturePoints.insert(item)
             }
             }*/
        }
        
    }
    
    
    // MARK: - ARSessionObserver
    
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        // Remove optional error messages.
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            print("ERROR: \(errorMessage)")
            print("TODO: show error as an alert.")
        }
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return true
    }
    
}



