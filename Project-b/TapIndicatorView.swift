//
//  TapIndicatorView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//

import SwiftUI

struct TapIndicator: Identifiable, Hashable {
    let x: CGFloat
    let y: CGFloat
    let imageFile: String
    let quantity: Int
    let id = UUID()
}

struct TapIndicatorView: View {
    let imageName: String
    let quantity: Int
    @Binding var panning: Bool
    
    @State var xOffset = CGFloat.random(in: -10..<10)
    @State var targetY = CGFloat(0)
    @State var opacity: Double = 2
    
    var body: some View {
        ZStack {
            Image(imageName)

            Text("+\(quantity)")
                .offset(x: 20)
                .foregroundColor(.white)
        }
        .offset(x: -15 + xOffset, y: targetY)
        .animation(panning ? .none : .easeOut(duration: 0.7))
        .opacity(opacity)
        .animation(.easeOut(duration: 0.7))
        .onAppear {
            targetY = -50
            opacity = 0
        }
        
    }
}

struct TapIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        TapIndicatorView(imageName: "food-resource", quantity: 15, panning: .constant(true))
    }
}
