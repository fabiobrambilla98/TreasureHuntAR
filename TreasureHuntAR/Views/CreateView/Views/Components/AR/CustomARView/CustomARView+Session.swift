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
        
        
        
        if presenterType == .create {
            
            if createViewPresenter!.caputureImage {
                let image = CIImage(cvPixelBuffer: frame.capturedImage)
                let orientation = CGImagePropertyOrientation(rawValue: UInt32(UIDevice.current.orientation.rawValue))
                
                let context = CIContext(options: [.useSoftwareRenderer: false])
                guard let data = context.jpegRepresentation(of: image.oriented(orientation!),
                                                            colorSpace: CGColorSpaceCreateDeviceRGB(),
                                                            options: [kCGImageDestinationLossyCompressionQuality as CIImageRepresentationOption: 0.7])
                else {
                    return
                }
                
                
                createViewPresenter!.startingPointCapturedImage = data
                createViewPresenter!.caputureImage = false
            }
            
            
            
            switch frame.worldMappingStatus {
            case .extending, .mapped:
                if(!createViewPresenter!.saveButtonEnabled) {
                    createViewPresenter!.saveButtonEnabled = true
                }
                
            default:
                if(createViewPresenter!.saveButtonEnabled) {
                    createViewPresenter!.saveButtonEnabled = false
                }
                
                
            }
            
            if(actionButtonsAnchorEntity != nil) {
                actionButtonsAnchorEntity!.billboard(targetPosition: self.cameraTransform.translation)
                
            }
        }
        
        
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





