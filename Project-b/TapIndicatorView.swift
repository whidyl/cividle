//
//  TapIndicatorView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//

import SwiftUI

struct TapIndicator: Identifiable {
    let imageFile: String
    let quanitity: Int
    let id = UUID()
}

struct TapIndicatorView: View {
    let imageName: String
    let quantity: Int
    let xOffset = CGFloat.random(in: -10..<10)
    @State var targetY = CGFloat(0)
    @State var opacity: Double = 2
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaleEffect(0.5)
            Text("+\(quantity)")
                .offset(x: 20)
                .foregroundColor(.white)
        }
        .offset(x: -15 + xOffset, y: targetY)
        .animation(.linear(duration: 2))
        .opacity(opacity)
        .animation(.easeOut(duration: 1.2))
        .onAppear {
            targetY = -100
            opacity = 0
        }
        
    }
}

struct TapIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        TapIndicatorView(imageName: "food-resource", quantity: 15)
    }
}
