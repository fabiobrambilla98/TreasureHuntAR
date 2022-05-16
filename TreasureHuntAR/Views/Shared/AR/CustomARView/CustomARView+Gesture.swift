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
    
    @objc func handleEntityGesture(_ sender: UIGestureRecognizer) {
        // Scale
        if let scaleGesture = sender as? EntityScaleGestureRecognizer {
            switch scaleGesture.state {
            case .began:
                print("SCALE: BEGAN")
            case .changed:
                print("")// Handle things during the gesture
            case .ended:
                let entity = scaleGesture.entity! as? CustomModelEntity
                let scale = entity?.transform.scale
                self.sessionModelEntities = self.sessionModelEntities.map({if($0.identifier == entity?.identifier) {$0.size = scale!}; return $0})
               
            default:
                return
            }
        } else if let rotationGesture = sender as? EntityRotationGestureRecognizer {
            switch rotationGesture.state {
            case .began:
                print("ROTATION: BEGAN")
            case .changed:
                print("")
            case .ended:
                let entity = rotationGesture.entity! as? CustomModelEntity
                let orientation = entity?.orientation
                self.sessionModelEntities = self.sessionModelEntities.map({if($0.identifier == entity?.identifier) {$0.orient = Orientation(angle: orientation!.angle, axis: orientation!.axis)}; return $0})
               
            default:
                return
            }
        } 
        
        
        
        
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
                    if tappedObject!.name.hasPrefix(Utils.treasurePrefix.rawValue) {
                        presenter.treasurePlaced = false
                    }
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
                } else if let entity = entity as? CustomModelEntity, entity.name == "parchmentText" ||  entity.name.hasPrefix(Utils.parchmentPrefix.rawValue) || entity.name.hasPrefix(Utils.treasurePrefix.rawValue) {
                    if(tappedObject != nil) {
                        self.scene.removeAnchor(actionButtonsAnchorEntity as! AnchorEntity)
                        actionButtonsAnchorEntity = nil
                        tappedObject=nil
                        return
                    }
                    
                    let planeAnchor = ARAnchor(name: "actionButtons", transform: entity.parent!.transformMatrix(relativeTo: nil))
                    
                    tappedObject = entity
                    self.session.add(anchor: planeAnchor)
                    
                    
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
                
                
                if(virtualObjectAnchor!.name!.hasPrefix(Utils.parchmentPrefix.rawValue)){
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
                if let entity = entity as? CustomModelEntity, entity.name.hasPrefix(Utils.parchmentPrefix.rawValue) {
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
                } else if let entity = entity as? CustomModelEntity, entity.name.hasPrefix(Utils.treasurePrefix.rawValue) {
                    withAnimation(.easeIn) {
                        presenter.treasureFound = true
                    }
                }
                
                
            }
        }
        
        
    }
}
