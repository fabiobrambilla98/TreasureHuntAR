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
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(self.tapRecognizer!)
    }
    
    // MARK: - Placing AR Content
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        if let presenter = self.viewPresenter as? CreateViewPresenter{
            
            
            // Disable placing objects when the session is still relocalizing
            if isRelocalizingMap && virtualObjectAnchor == nil && presenter.showAlert{
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
                    self.sessionModelEntities.remove(tappedObject!.objectEntity!.identifier)
                    self.scene.removeAnchor(actionEntity)
                    self.scene.removeAnchor(tappedObject!.anchor!)
                    
                    tappedObject = nil
                } else if entity.name == "modifyButton" {
                    
                    presenter.parchmentText = tappedObject!.parchmentText!.replacingOccurrences(of: "\n", with: "")
                    presenter.objectToAdd = tappedObject?.objectEntity
                    presenter.parchmentToModify = tappedObject
                    presenter.showParchment = true
                    tappedObject?.removeChild((tappedObject?.children[0])!)
                } else if let entity = entity as? CustomModelEntity, entity.name == "parchmentText" ||  entity.name == "parchment" || entity.name == "treasure" {
                    if(tappedObject != nil) {
                        return
                    }
                    
                    let planeAnchor = ARAnchor(name: "actionButtons", transform: entity.parent!.transformMatrix(relativeTo: nil))
                    
                    self.session.add(anchor: planeAnchor)
                    tappedObject = entity
                    
                }
            } else {
                
                if(presenter.objectToAdd == nil) {
                    return
                }
                
                guard let name = presenter.objectToAdd?.modelEntity?.name else {
                    return
                }
                
                virtualObjectAnchor = ARAnchor(
                    name: name,
                    transform: hitTestResult.worldTransform
                )
                
                virtualObjectAnchor!.arID = presenter.objectToAdd!.identifier
                
                
                if(virtualObjectAnchor!.name == "parchment"){
                    presenter.showParchment = true
                }
                
                self.session.add(anchor: virtualObjectAnchor!)
                
            }
            
        } else if let presenter = self.viewPresenter as? PlayViewPresenter {
            
            guard let point = sender?.location(in: self),
                  let hitTestResult = self.hitTest(
                    point,
                    types: [.existingPlaneUsingGeometry, .estimatedHorizontalPlane, .estimatedVerticalPlane]
                  ).first
            else {
                return
            }
            
            
            if let entity = self.entity(at: point) {
                if let entity = entity as? CustomModelEntity, entity.name == "parchment" {
                    if (!entity.tapped) {
                        var model: StoreModelEntity?
                        for m in presenter.mapSessions[presenter.currentSession].modelEntities {
                            
                            if(m.identifier == entity.identifier) {
                                model = m
                                presenter.parchmentsFound.append((entity.objectEntity as! ParchmentEntity, model!.text))
                                
                            }
                        }
                        entity.tapped = true
                        presenter.sessionClueFound += 1
                    }
                }
                
                
            }
        }
        
        
    }
}
