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
        ZStack {
            GameMap()
            ResourcePanel()
        }
        .environmentObject(viewModel)
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
    @State var fingerPos = CGPoint.zero
    
    var fingerLocGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                fingerPos = value.location
            }
    }

    var panGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { gesture in
                var newPanPosition = panStartPosition ?? panPosition // before panStartPosition is updated, we can just use the current position
                fingerPos = gesture.location
                newPanPosition.width += gesture.translation.width
                newPanPosition.height += gesture.translation.height
                self.panPosition = newPanPosition
            }
            .updating($panStartPosition) { (value, panStartPosition, transaction) in
                // When gesture starts, panStartPosition is "locked into" the initial panPosition. It resets with a future drag gesture because panStartPosition is nil when gesture ends
                panStartPosition = panStartPosition ?? panPosition
            }
    }
    
    var tapGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.0)
            .onChanged { value in
                print("tapped \(value)")
            }
    }
    
    
    var body: some View {
        let panAndLoc = panGesture.simultaneously(with: fingerLocGesture)
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: viewModel.cols)
        VStack {
            Text("\(fingerPos.x) \(fingerPos.y)")
            ZStack {
            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach( 0..<viewModel.rows) { r in
                    ForEach( 0..<viewModel.cols) { c in
                        HexTileView(r: r, c: c)
                            .frame(width: imgsize.width, height: imgsize.height)
                            .offset(x: hexagonWidth*CGFloat(r)/2 + spacing*CGFloat(r)/2)
                            .environmentObject(viewModel)
                    }
                    .frame(width: hexagonWidth, height: imgsize.height * 0.63)
                }
            }
            }
        }
        .frame(width: (hexagonWidth + spacing) * CGFloat(viewModel.cols-1))
        .position(x: panPosition.width, y: panPosition.height)
        .highPriorityGesture(panAndLoc)
        .animation(.linear(duration: 0.1))
        .scaleEffect(1.2)
    }
}

struct HexTileView: View {
    @EnvironmentObject var viewModel: GameViewModel
//    let tileName: String
//    let overlayName: String?
    let r: Int
    let c: Int
    @State var tapIndicators: [TapIndicator] = []
    
    var body: some View {
        ZStack {
            Image(viewModel.map.data[r][c].name)
            .resizable()
            .overlay(
                Image(viewModel.map.data[r][c].overlay ?? "")
                .offset(y: -9)
                .allowsHitTesting(false)
            )
            ForEach(tapIndicators) { indicator in
                TapIndicatorView(imageName: indicator.imageFile, quantity: 1)
            }
        }
        .onTapGesture {
            //viewModel.setGrass(r: r, c: c)
            if let rec = viewModel.yieldTerrain(terrain: viewModel.map.data[r][c]) {
                tapIndicators.append(TapIndicator(initialPos: CGPoint.zero, imageFile: ResourceImageFileNames[rec]!, quanitity: 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    tapIndicators.removeFirst()
                }
            }
            //print(tapIndicators)
            print(viewModel.map.data[r][c].name)
        }
            
    }
}

struct ResourcePanel: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    let coloumns = Array(repeating: GridItem(.fixed(50), spacing: 20), count: 5)
    
    var body: some View {
        ZStack {
            ScrollView () {
                LazyVGrid(columns: coloumns) {
                    ForEach(viewModel.resourseInventory.values.filter { $0.quantity > 0 }, id: \.self) { resourceInfo in
                        ZStack {
                            Image(resourceInfo.imageFile)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                            Text("\(resourceInfo.quantity)")
                                .foregroundColor(.white)
                                .offset(x: 10, y: 10)
                        }
                    }
                }
                .padding(Edge.Set.top, 50)
            }
            .frame(height: 200)
            .background(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.65))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        
    }
}

struct TapIndicator: Identifiable {
    let initialPos: CGPoint
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GameViewModel())
    }
}
