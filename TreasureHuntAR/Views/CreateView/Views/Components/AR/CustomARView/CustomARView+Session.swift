//
//  CustomARView+Session.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import Foundation
import RealityKit
import ARKit

extension CustomARView: ARSessionDelegate {
    
    // MARK: - AR session delegate
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
    }
    
    // This is where we render virtual contents to scene.
    // We add an anchor in `handleTap` function, it will then call this function.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("did add anchor: \(anchors.count) anchors in total")
        
        for anchor in anchors {
            addAnchorEntityToScene(anchor: anchor)
        }
    }
    
    /// - Tag: CheckMappingStatus
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Enable Save button only when the mapping status is good and an object has been placed
        
       
        
        
        
        switch frame.worldMappingStatus {
        case .extending, .mapped:
            Observed.shared.oberved = true
        default:
            Observed.shared.oberved = false
        }
       
        
        if(actionButtonsAnchorEntity != nil) {
            actionButtonsAnchorEntity!.billboard(targetPosition: self.cameraTransform.translation)
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
    
}

