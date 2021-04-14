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
    @State var watching: MapPos?
    @State var ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var triggerUpdate = false
    @State var shopSelection: ShopSelection?

    var body: some View {
        ZStack {
            GameContent(watching: $watching, triggerUpdate: $triggerUpdate, shopSelection: $shopSelection)
            ActionPanelView(shopSelection: $shopSelection)
            InfoPanelView(watching: $watching) 
        }
        .environmentObject(viewModel)
        .ignoresSafeArea()
        .onReceive(ticker, perform: { _ in
            viewModel.tick()
            triggerUpdate.toggle()
        })
    }
    
}







//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: GameViewModel())
//    }
//}
