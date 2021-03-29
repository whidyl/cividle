//
//  TapIndicatorsView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/24/21.
//

import SwiftUI
import Deque

struct TapIndicatorsView: View {
    @Binding var tapIndicators: Deque<TapIndicator>
    @Binding var panning: Bool
    
    
    var body: some View {
        ZStack {
            ForEach(tapIndicators, id: \.self) { indicator in
                TapIndicatorView(imageName: indicator.imageFile, quantity: 1, panning: $panning)
                    .position(x: indicator.x, y: indicator.y)
            }
        }
    }
}

//struct TapIndicatorsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TapIndicatorsView()
//    }
//}
