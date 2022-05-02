//
//  ContentLink.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI

enum ContentLink: Hashable, Identifiable {
    case createView
    case selectView
    case playView
    
    var navigationLink: ContentLink {
        return self
    }

    var id: String {
        switch self {
        case .createView:
            return "createView"
        case .selectView:
            return "selectView"
        case .playView:
            return "playView"
        
        }
    }
}
