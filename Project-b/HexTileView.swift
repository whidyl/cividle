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
    @Binding var animationStep: Int
    @Binding var panning: Bool
    
    @State var tapIndicators = Deque<TapIndicator>()
    
    //TODO: use queue to fix tap indicator
    
    var body: some View {
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
                    Image(structure.imageFiles[animationStep]!)
                        .resizable()
                }
                
                ForEach(tapIndicators, id: \.self) { indicator in 
                    TapIndicatorView(imageName: indicator.imageFile, quantity: 1, panning: $panning)
                }
                
            }
        }
        .onTapGesture {
            //viewModel.setGrass(r: r, c: c)
            if let rec = viewModel.yieldTerrain(terrainType: viewModel.map.at(r, c)) {
                tapIndicators.append(TapIndicator(imageFile: Resources[rec]!.imageFile, quanitity: 1))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    tapIndicators.removeFirst()
                }
            }
            //print(tapIndicators)
        }
            
    }
}

struct HexTileView_Previews: PreviewProvider {
    static var previews: some View {
        HexTileView(r: 0, c: 0, animationStep: .constant(0), panning: .constant(false))
    }
}
