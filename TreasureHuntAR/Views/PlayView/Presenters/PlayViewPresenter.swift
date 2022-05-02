//
//  PlayViewPresenter.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI


protocol PlayViewPresenting: ObservableObject, Identifiable {
    
}


final class PlayViewPresenter: Presenters, PlayViewPresenting {
    
    private var service: AppService = AppService.shared
    @Published var showParchmentSheet: Bool = false
    var parchmentsFound: [(String, String)] = []
    
    
    override init() {
       
    }

}
