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
    
    let mapPos: MapPos
    
    @Binding var panning: Bool
    @Binding var tapIndicators: Deque<TapIndicator>
    @Binding var watching: MapPos?
    
    var body: some View {
        GeometryReader { geometry in
            let midX =  geometry.frame(in: .global).midX
            let midY = geometry.frame(in: .global).midY
            

            ZStack {
                let terrainInfo = viewModel.terrainMap.terrainInfoAt(mapPos)
                
                if viewModel.terrainMap.typeAt(mapPos) != .nothing {
                    if let overlay = terrainInfo.overlay {
                        Image(terrainInfo.imageFile)
                            .overlay(Image(overlay).offset(y: -8).allowsHitTesting(false))
                    } else {
                        Image(terrainInfo.imageFile)
                    }

                    if let structure = viewModel.structureAt(mapPos) {
                        Image(structure.imageFile)
                    }

                }
            }
            .brightness(watching == mapPos ? 0.2: 0) // highlight selected tile
            .simultaneousGesture(
                TapGesture().onEnded {
                    if let structure = viewModel.structureAt(mapPos) {
                        // TODO: needs to work with multi-storage structures
                        let resourceImage = resourceImageFileOf(structure.storageSlots[0].resourceType)
                        let quantity = structure.storageSlots[0].quantity
                        let collected = viewModel.collectAllOfStructure(at: mapPos)
                        if collected > 0 {
                            tapIndicators.append(TapIndicator(x: midX, y: midY, imageFile: resourceImage, quantity: quantity))
                        }
                    } else if let resource = viewModel.yieldTerrain(terrainType: viewModel.terrainMap.typeAt(mapPos)) {
                        tapIndicators.append(TapIndicator(x: midX, y: midY, imageFile: resourceImageFileOf(resource), quantity: 1))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            tapIndicators.removeFirst()
                        }
                    }
                }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5).onEnded() { _ in watching = mapPos }
            )
        }
            
    }
}
