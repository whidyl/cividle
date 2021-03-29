//
//  InfoPanelView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/24/21.
//

import SwiftUI

struct InfoPanelView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Binding var watching: MapPos?
    
    var body: some View {
        ZStack {
            ScrollView () {
                if watching != nil {
                    let info = viewModel.structures[watching!]
                    HStack {
                        VStack {
                            Text("\(info!.name)")
                                .bold()
                            Image("\(info!.iconFile)")
                        }
                        .padding(50)
                        Spacer()
                        
                        Text("\(info!.description)")
                            .padding(Edge.Set.top, 40)
                            .padding(Edge.Set.horizontal, 20)
                        
                    }
                    .foregroundColor(.white)
                }
            }
            .frame(height: 200)
            .background(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.65))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

//struct InfoPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoPanelView()
//    }
//}
