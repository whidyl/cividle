//
//  GameContent.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/31/21.
//

import SwiftUI
import Deque


struct GameContent: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    @State var panning = false // using this to fix animation of tap indicators
    @State var tapIndicators = Deque<TapIndicator>()
    @Binding var watching: MapPos?
    
    var body: some View {
        ZStack {
            GameMapView(panning: $panning, tapIndicators: $tapIndicators, watching: $watching)
            TapIndicatorsView(tapIndicators: $tapIndicators, panning: $panning)
        }
    }
}


