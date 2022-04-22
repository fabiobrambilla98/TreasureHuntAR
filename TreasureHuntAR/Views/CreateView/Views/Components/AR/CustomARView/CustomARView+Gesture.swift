//
//  CustomARView+Gesture.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import ARKit
import RealityKit
import Combine


extension Entity {
    /// Billboards the entity to the targetPosition which should be provided in world space.
    func billboard(targetPosition: SIMD3<Float>) {
        look(at: targetPosition, from: position(relativeTo: nil), relativeTo: nil)
    }
}



extension CustomARView {
    func enableObjectRemoval() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
        
        let location = recognizer.location(in: self)
        if let entity = self.entity(at: location) {
            
            if let anchorEntity = entity.anchor, entity.name == self.virtualObjectAnchorName {
                
                guard test.anchor == nil else {
                    return
                }
                
                let planeAnchor = ARAnchor(name: "test", transform: (entity.parent?.transformMatrix(relativeTo: nil))!)
                
                self.test.entity = entity
                self.session.add(anchor: planeAnchor)
                
        
            }
        }
    }
}






extension CustomARView {
    
    /// Add the tap gesture recogniser
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: - Placing AR Content
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // Disable placing objects when the session is still relocalizing
        if isRelocalizingMap && virtualObjectAnchor == nil {
            return
        }
        
        
        
        // Hit test to find a place for a virtual object.
        guard let point = sender?.location(in: self),
              let hitTestResult = self.hitTest(
                point,
                types: [.existingPlaneUsingGeometry, .estimatedHorizontalPlane, .estimatedVerticalPlane]
              ).first
        else {
            return
        }
    
        
        if let entity = self.entity(at: point) {
            if let deleteAnchorEntity = entity.anchor, entity.name == "test" {
                
                self.scene.removeAnchor(deleteAnchorEntity)
                self.scene.removeAnchor(self.test.entity!.anchor!)
                self.test = Prova()
            }
        } else {
            
            if(self.presenter.presenter.objectToAdd == nil) {
                return
            }
            
            
            virtualObjectAnchor = ARAnchor(
                name: (self.presenter.presenter.objectToAdd?.modelEntity?.name)!,
                transform: hitTestResult.worldTransform
            )
        
            self.session.add(anchor: virtualObjectAnchor!)
        }
        
        
        
        
        
        
        
    }
    
}

