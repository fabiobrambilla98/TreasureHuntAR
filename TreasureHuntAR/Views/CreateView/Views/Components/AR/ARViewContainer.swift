//
//  ARViewContainer.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
    @ObservedObject var presenter: CreateViewPresenter
    
    func makeUIView(context: Context) -> CustomARView {
        
        let arView = CustomARView(frame: .zero)
        arView.presenter = OOPresenter(presenter: self.presenter)
        
        arView.setup()
        
       
        UIApplication.shared.isIdleTimerDisabled = true
        
        return arView
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    func makeCoordinator() -> ARViewCoordinator{
        ARViewCoordinator(self)
    }
    
    
}

class ARViewCoordinator: NSObject, ARSessionDelegate {
    var arVC: ARViewContainer
    
    init(_ control: ARViewContainer) {
        self.arVC = control
    }
    
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        /*switch(frame.worldMappingStatus) {
        case .mapped, .extending:
            Observed.shared.oberved = true
        default:
            if(Observed.shared.oberved) {
                Observed.shared.oberved = false
            }
            return
        }*/
    }
}
