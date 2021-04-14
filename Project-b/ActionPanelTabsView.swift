//
//  ActionPanelTabsView.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 4/9/21.
//

import SwiftUI

struct ActionPanelTabsView: View {
    @Binding var selectedTab: Tab
    @Binding var shopSelection: ShopSelection?
    
    var body: some View {
        HStack {
            Spacer()
            Text("Resources")
                .onTapGesture {
                    selectedTab = .resources
                    shopSelection = nil
                }
                .foregroundColor(selectedTab == .resources ? .gray : .white)
            Spacer()
            Text("Shop")
                .onTapGesture {
                    selectedTab = .shop
                }
                .foregroundColor(selectedTab == .shop ? .gray : .white)
            Spacer()
            Text("Upgrades")
                .onTapGesture {
                    selectedTab = .upgrades
                    shopSelection = nil
                }
                .foregroundColor(selectedTab == .upgrades ? .gray : .white)
            Spacer()
        }
        .frame(height: 50)
        .foregroundColor(.white)
        .background(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.65))
    }
}

enum Tab {
    case resources
    case shop
    case upgrades
}
