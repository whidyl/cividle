//
//  ContentView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//
// ! nano tiles as a minimap view (unlocked with something like map-making)

import SwiftUI
import Deque

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    //@State var animationStep = 0
    @State var tapIndicators = Deque<TapIndicator>()
    @State var panning = false
    @State var watching: MapPos?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            GameMapView(panning: $panning, tapIndicators: $tapIndicators, watching: $watching)
            TapIndicatorsView(tapIndicators: $tapIndicators, panning: $panning)
            ResourcePanelView()
            InfoPanelView(watching: $watching) 
        }
        .environmentObject(viewModel)
        .ignoresSafeArea()
        .onReceive(timer, perform: { _ in
            viewModel.tick()
        })
    }
    
}







//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: GameViewModel())
//    }
//}
