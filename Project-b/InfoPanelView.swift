//
//  InfoPanelView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/24/21.
//
//! input/output display: inIcon1*x + inIcon2*y = outIcon*z
import SwiftUI

struct InfoPanelView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Binding var watching: MapPos?
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView () {
                if watching != nil {
                    if let info = viewModel.structures[watching!] {
                        HStack {
                            VStack {
                                Text("\(info.name)")
                                    .bold()
                                Image(info.iconFile)
                            }
                            .padding(50)
                            Spacer()
                            
                            Text("\(info.description)")
                                .padding(Edge.Set.top, 40)
                                .padding(Edge.Set.horizontal, 20)
                            Text("Storage: \(info.storageSlots[0].quantity)") //TODO: display set of storages with resource icons
                            
                        }
                        .foregroundColor(.white)
                    } else if let type = viewModel.terrainMap.typeAt(MapPos(watching!.r, watching!.c)) {
                        HStack {
                            VStack {
                                Text("\(Terrains[type]!.imageFile)")
                                    .bold()
                                Image(Terrains[type]!.imageFile)
                            }
                            .padding(50)
                            Spacer()
                            
                            Text("TODO: Descriptions for terrain")
                                .padding(Edge.Set.top, 40)
                                .padding(Edge.Set.horizontal, 20)
                            
                        }
                        .foregroundColor(.white)
                    }
                }
            }
            .frame(height: 200)
            .background(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.65))
            Text("$\(viewModel.money)").multilineTextAlignment(.leading)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

//struct InfoPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoPanelView()
//    }
//}
