//
//  ARViewContainer.swift
//  TreasureHuntAR
//
//  Created by MacBook on 22/04/22.
//

import SwiftUI
import ARKit
import RealityKit

protocol PresentersProtocol: ObservableObject {
    
}
class Presenters: PresentersProtocol {
    init() {
        
    }
}



struct ARViewContainer: UIViewRepresentable {
    
    @ObservedObject var presenter: Presenters
    
    func makeUIView(context: Context) -> CustomARView {
        
        let arView = CustomARView(frame: .zero)
        arView.viewPresenter = self.presenter
        
        
        arView.setup(mode: ((presenter as? CreateViewPresenter) != nil) ? .create : .play)
        
        arView.renderOptions = [.disableMotionBlur,
                                .disableDepthOfField,
                                .disableGroundingShadows,
                                .disableHDR]
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        return arView
        
        
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        if let presenter = self.presenter as? CreateViewPresenter {
            if(presenter.addingParchmentText) {
                let text = presenter.parchmentText
                uiView.addTextToParchment(text: text)
                presenter.parchmentText = ""
                presenter.addingParchmentText = false
            }
            
            if(presenter.saveSessionButtonPressed) {
                uiView.saveSession()
                presenter.saveSessionButtonPressed = false
            }
            
            if(presenter.loadSessionPressed.0) {
                uiView.loadSession(number: presenter.loadSessionPressed.1)
                presenter.loadSessionPressed = (false, 0)
            }
            
            if(presenter.newSessionButtonPressed) {
                uiView.newSession()
                presenter.newSessionButtonPressed = false
            }
            
        } else if let presenter = self.presenter as? PlayViewPresenter {
            
            if(presenter.nextSessionButtonPressed.0) {
                uiView.loadSession(number: presenter.nextSessionButtonPressed.1)
                presenter.nextSessionButtonPressed = (false, 0)
            }
            
        }
        
    }
    
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
        
        
        
    }
}
