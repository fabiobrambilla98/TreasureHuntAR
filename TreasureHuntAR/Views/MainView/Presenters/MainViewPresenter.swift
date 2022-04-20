//
//  MainPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

protocol MainViewPresenting: ObservableObject {
    
    func open(_ view: ViewSelection )
}


final class MainViewPresenter: MainViewPresenting, ContentFlowStateProtocol{
    
    @Published var activeLink: ContentLink?
    
    
    init() {
        
    }
    
    func open (_ view: ViewSelection) {
        switch(view) {
        case .playView:
            activeLink = .playView
        case .createView:
            activeLink = .createView
        }
    }
}



