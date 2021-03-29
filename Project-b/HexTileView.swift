//
//  HexTileView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//

import SwiftUI
import Deque

struct HexTileView: View {                       
    @EnvironmentObject var viewModel: GameViewModel
    
    let r: Int
    let c: Int
    
    //@Binding var animationStep: Int
    @Binding var panning: Bool
    @Binding var tapIndicators: Deque<TapIndicator>
    @Binding var watching: MapPos?
    
    var body: some View {
        //let isWatching = watching == viewModel.structures[MapPos(r: r, c: c)]
        GeometryReader { geometry in
            ZStack {
                let terrainType = viewModel.map.at(r, c)
                let terrainInfo = Terrains[terrainType]!
                let structure = viewModel.structures[MapPos(r: r, c: c)]
                if terrainType != TerrainType.nothing {
                    if terrainInfo.overlay != nil {
                        Image(terrainInfo.imageFile)
                            .resizable()
                            .overlay(
                                Image(terrainInfo.overlay!)
                                    .offset(y: -9)
                                    .allowsHitTesting(false)
                            )
                    } else {
                        Image(terrainInfo.imageFile)
                            .resizable()
                    }

                    if let structure = structure as? AnimatedStructure {
                        Image(structure.imageFile)
                            .resizable()
                    }

                }
            }
            .brightness(watching == MapPos(r: r, c: c) ? 0.2: 0)
            .simultaneousGesture( TapGesture().onEnded {
                    //viewModel.setGrass(r: r, c: c)
                    print("\(geometry.frame(in: .global).midX), \(geometry.frame(in: .global).midY)")
                    if let rec = viewModel.yieldTerrain(terrainType: viewModel.map.at(r, c)) {
                        tapIndicators.append(TapIndicator(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY, imageFile: Resources[rec]!.imageFile, quantity: 1))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            tapIndicators.removeFirst()
                        }
                    }
                    //print(tapIndicators)
                }
            )
            .simultaneousGesture( LongPressGesture(minimumDuration: 0.5).onEnded() { _ in
                    watching = MapPos(r: r, c: c)
                }
            )
        }
            
    }
}

//struct HexTileView_Previews: PreviewProvider {
//    static var previews: some View {
//        HexTileView(r: 0, c: 0, animationStep: .constant(0), panning: .constant(false))
//    }
//}
