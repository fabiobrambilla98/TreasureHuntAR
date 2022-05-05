//
//  SelectViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 02/05/22.
//

import SwiftUI


protocol SelectViewPresenting: ObservableObject {
    func open(_ view: ViewSelection )
}


final class SelectViewPresenter: SelectViewPresenting, ContentFlowStateProtocol {
    @Published var activeLink: ContentLink?
    
    private var service: AppService = AppService.shared
    var treasureHuntListNames: [String] = []
    
    init() {
        self.treasureHuntListNames = self.service.getAllStoredMapNames()
    }
    
    func open (_ view: ViewSelection) {
        switch(view) {
        case .playView:
            activeLink = .playView
        case .createView:
            activeLink = .createView
        default:
            activeLink = .selectView
        }
    }

}
