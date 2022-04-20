//
//  AppCoordinator.swift
//  TreasureHuntAR
//
//  Created by MacBook on 19/04/22.
//

import SwiftUI



protocol ContentFlowStateProtocol: ObservableObject {
    var activeLink: ContentLink? { get set }
}


struct ContentFlowCoordinator<State: ContentFlowStateProtocol, Content: View>: View {

    @ObservedObject var state: State
    let content: () -> Content

    private var activeLink: Binding<ContentLink?> {
        $state.activeLink.map(get: { $0?.navigationLink }, set: { $0 })
    }


    var body: some View {
        NavigationView {
            ZStack {
                content()
                navigationLinks
            }
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder private var navigationLinks: some View {
    
        NavigationLink(tag: .createView, selection: activeLink, destination: createViewDestination) { EmptyView() }
        NavigationLink(tag: .playView, selection: activeLink, destination: playViewDestination) { EmptyView() }
    }

    private func createViewDestination() -> some View {
        let presenter = CreateViewPresenter()
        let view = CreateView(presenter: presenter)
        return view
    }
    
    private func playViewDestination() -> some View {
        let presenter = PlayViewPresenter()
        let view = PlayView(presenter: presenter)
        return view
    }

}
