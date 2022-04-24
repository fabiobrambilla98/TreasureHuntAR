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
        look(at: targetPosition, from: position(relativeTo: nil), upVector: [0,1,0], relativeTo: nil)
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
            if let actionEntity = entity.anchor, entity.name == "deleteButton" {
                self.scene.removeAnchor(actionEntity)
                self.scene.removeAnchor(tappedObject!.anchor!)
                tappedObject = nil
                
            } else if entity.name == "modifyButton" {
                
                presenter.presenter.parchmentText = tappedObject!.parchmentText!.replacingOccurrences(of: "\n", with: "")
                presenter.presenter.objectToAdd = tappedObject?.objectEntity
                presenter.presenter.parchmentToModify = tappedObject
                presenter.presenter.showParchment = true
                tappedObject?.removeChild((tappedObject?.children[0])!)
            } else if entity.type == .none {
                
                let planeAnchor = ARAnchor(name: "parchmentActionButtons", transform: entity.transformMatrix(relativeTo: nil))
                //(entity.parent?.transformMatrix(relativeTo: nil))
                self.session.add(anchor: planeAnchor)
                tappedObject = entity
            }
        } else {
            
            if(self.presenter.presenter.objectToAdd == nil) {
                return
            }
            
            
            virtualObjectAnchor = ARAnchor(
                name: (self.presenter.presenter.objectToAdd?.modelEntity?.name)!,
                transform: hitTestResult.worldTransform
            )
        
            self.presenter.presenter.showParchment = true
            self.session.add(anchor: virtualObjectAnchor!)
            
        }
   
    }
    
}

