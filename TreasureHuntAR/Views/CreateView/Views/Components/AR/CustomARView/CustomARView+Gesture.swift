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
    func billboard(targetPosition: SIMD3<Float>) {
        look(at: targetPosition, from: position(relativeTo: nil), relativeTo: nil)
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
            } else if entity.name == "parchmentText" ||  entity.name == "parchment" || entity.name == "treasure" {
                if(tappedObject != nil) {
                    return
                }
                
                let planeAnchor = ARAnchor(name: "actionButtons", transform: entity.parent!.transformMatrix(relativeTo: nil))
                
                self.session.add(anchor: planeAnchor)
                tappedObject = entity
                
            }
        } else {
            
            if(self.presenter.presenter.objectToAdd == nil) {
                return
             }
                
                guard let name = self.presenter.presenter.objectToAdd?.modelEntity?.name else {
                    return
                }
                
                virtualObjectAnchor = ARAnchor(
                    name: name,
                    transform: hitTestResult.worldTransform
                )
                
                if(virtualObjectAnchor!.name == "parchment"){
                    self.presenter.presenter.showParchment = true
                }
                
                self.session.add(anchor: virtualObjectAnchor!)
                
            }
            
        }
        
    
}
