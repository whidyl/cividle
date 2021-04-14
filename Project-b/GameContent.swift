//
//  GameContent.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/31/21.
//

import SwiftUI
import Deque
import Combine

struct GameContent: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    @State var panning = false // using this to fix animation of tap indicators
    @State var tapIndicators = Deque<TapIndicator>()
    @Binding var watching: MapPos?
    @Binding var triggerUpdate: Bool
    @Binding var shopSelection: ShopSelection?
    
    var body: some View {
        ZStack {
            GameMapView(panning: $panning, tapIndicators: $tapIndicators, watching: $watching, triggerUpdate: $triggerUpdate, shopSelection: $shopSelection)
            TapIndicatorsView(tapIndicators: $tapIndicators, panning: $panning)
        }
    }
}


