//
//  ActionPanelView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 4/9/21.
//

import SwiftUI

struct ActionPanelView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    @State var selectedTab: Tab = .resources
    
    @Binding var shopSelection: ShopSelection?
    
    var body: some View {
        VStack (alignment: .leading) {
            Spacer().frame(maxHeight: .infinity)
            ActionPanelTabsView(selectedTab: $selectedTab, shopSelection: $shopSelection).frame(alignment: .bottom)
            switch selectedTab {
            case .resources:
                ResourcePanelView()
            case .shop:
                ShopPanelView(shopSelection: $shopSelection)
            default:
                ResourcePanelView()
            }
            
        }
        .frame(maxHeight: .infinity)
        
    }
    
}
