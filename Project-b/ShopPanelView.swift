//
//  ShopPanelView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 4/9/21.
//

import SwiftUI

struct ShopPanelView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    @Binding var shopSelection: ShopSelection?
    
    let coloumns = Array(repeating: GridItem(.fixed(200), spacing: 5), count: 6)
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyVGrid(columns: coloumns) {
                    ZStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color.gray)
                            .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay (
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: shopSelection?.stringValue == "sell" ? 3 : 0)
                                    .blur(radius: 5)
                            )
                        VStack {
                            Text("Sell")
                            //TODO: Image("sell-structure")
                        }
                    }
                    .onTapGesture {
                        if shopSelection?.stringValue == "sell" {
                            shopSelection = nil
                        } else {
                            shopSelection = .sell
                        }
                    }
                    ForEach(viewModel.purchasableStructures, id: \.id) { structure in
                        ZStack {
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(Color.gray)
                                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: shopSelection?.stringValue == structure.name ? 3 : 0)
                                        .blur(radius: 5)
                                )
                            VStack {
                                Text("\(structure.name)")
                                Image(structure.imageFile)
                                Text("$\(structure.price)")
                            }
                        }
                        .onTapGesture {
                            if shopSelection?.stringValue == structure.name {
                                shopSelection = nil
                            } else {
                                shopSelection = ShopSelection.structure(value: StructureType.init(rawValue: structure.name)!)
                            }
                        }
                        
                        
                    }
                }
                .padding(Edge.Set.top, 15)
            }
            .frame(height: 213)
            .background(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.65))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .bottom)
        
    }
}

enum ShopSelection {
    case structure(value: StructureType)
    case sell
    
    var stringValue: String {
        switch self {
        case .structure(let value):
            return value.rawValue
        case .sell:
            return "sell"
        }
    }
}
