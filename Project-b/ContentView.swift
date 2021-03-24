//
//  ContentView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//
// ! nano tiles as a minimap view (unlocked with something like map-making)

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    @State var animationStep = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            GameMapView(animationStep: $animationStep)
            ResourcePanelView()
        }
        .environmentObject(viewModel)
        .ignoresSafeArea()
        .onReceive(timer, perform: { _ in
            if animationStep < 3 {
                animationStep += 1
            } else {
                viewModel.tick()
                animationStep = 0
            }
        })
    }
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GameViewModel())
    }
}
