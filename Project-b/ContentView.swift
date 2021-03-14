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
    @State var selected: Int?

    var body: some View {
        VStack {
            GameMap()
                .environmentObject(viewModel)
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    
                    .ignoresSafeArea()
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        Text("\(viewModel.hand.count)")
                            .foregroundColor(.white)
                        ForEach(0..<viewModel.hand.count) { index in
                            ZStack {
                                if index < viewModel.hand.count{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 100)
                                        .overlay(
                                            Image(viewModel.hand[index].image)
                                                .resizable()
                                                .frame(width: 60, height: 52)
                                            
                                        )
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    
                }
                .padding(10)
            }
            .frame(height: 200, alignment: .bottom)
        }
        .ignoresSafeArea()
    }
    
}


/// Draws model's map as a grid of hexes.
struct GameMap: View {
    @EnvironmentObject var viewModel: GameViewModel
    let spacing: CGFloat = 4
    let imgsize = CGSize(width: 60, height: 52) // 15x13 pixelated hex is a 60x52 image so its not blurry
    var hexagonWidth: CGFloat { (imgsize.width / 2) * cos(.pi / 6) * 2 } // it just be like this
    @State var panPosition = CGSize(width: 200, height: 200)
    @GestureState var panStartPosition: CGSize?

    var panGesture: some Gesture {
        DragGesture(minimumDistance: CGFloat(0.1))
            .onChanged { gesture in
                var newPanPosition = panStartPosition ?? panPosition // before panStartPosition is updated, we can just use the current position
                newPanPosition.width += gesture.translation.width
                newPanPosition.height += gesture.translation.height
                self.panPosition = newPanPosition
            }
            .updating($panStartPosition) { (value, panStartPosition, transaction) in
                // When gesture starts, panStartPosition is "locked into" the initial panPosition. It resets with a future drag gesture because panStartPosition is nil when gesture ends
                panStartPosition = panStartPosition ?? panPosition
            }
    }
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: viewModel.cols)
        VStack {
            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach( 0..<viewModel.rows) { r in
                    ForEach( 0..<viewModel.cols) { c in
                        HexTileView(tileName: viewModel.map[r][c].name, overlayName: viewModel.map[r][c].overlay)
                            .frame(width: imgsize.width, height: imgsize.height)
                            .offset(x: hexagonWidth*CGFloat(r)/2 + spacing*CGFloat(r)/2)
                            .onTapGesture {
                                print(viewModel.map[r][c].name)
                                viewModel.playCard(card: viewModel.hand[0], r: r, c: c) //TODO: Maybe not the best solution
                            }
                    }
                    .frame(width: hexagonWidth, height: imgsize.height * 0.63)
                }
            }
        }
        .frame(width: (hexagonWidth + spacing) * CGFloat(viewModel.cols-1))
        .position(x: panPosition.width, y: panPosition.height)
        .gesture(panGesture)
        .animation(.linear(duration: 0.1))
        .scaleEffect(1.2)
    }
}

struct HexTileView: View {
    let tileName: String
    let overlayName: String?
    
    var body: some View {
        ZStack {
        Image(tileName)
            .resizable()
            .overlay(
            Image(overlayName ?? "")
                .offset(y: -9)
                .allowsHitTesting(false)
            )
        }
            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GameViewModel())
    }
}
