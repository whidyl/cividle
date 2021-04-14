//
//  ResourcePanelView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//

import SwiftUI

struct ResourcePanelView: View {
    //TODO: sell resources for money (export?)
    
    @EnvironmentObject var viewModel: GameViewModel
    
    let coloumns = Array(repeating: GridItem(.fixed(50), spacing: 20), count: 6)
    
    var body: some View {
        ZStack {
            ScrollView () {
                LazyVGrid(columns: coloumns) {
                    ForEach(viewModel.resourceInventory.filter{ $1 > 0 }.sorted(by: {$0.value > $1.value}), id: \.key) { resourceType, quantity in
                        ZStack {
                            Image(Resources[resourceType]!.imageFile)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                            Text("\(quantity)")
                                .foregroundColor(.white)
                                .offset(x: 10, y: 10)
                        }
                    }
                }
                .padding(Edge.Set.top, 15)
            }
            .frame(height: 213)
            .background(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.65))
            Button("Sell Goods") {
                viewModel.sellGoods()
            }.padding(.top, 70).padding(.leading, 200)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .bottom)
        
    }
}

struct ResourcePanelView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcePanelView()
    }
}
