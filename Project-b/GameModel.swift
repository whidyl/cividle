//
//  GameModel.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//

// !use terrain generation techniques to gen a 2d grid of ints, then use it as a template

import Foundation

struct GameModel {
    var terrainMap = TerrainMap()
    private(set) var resourceInventory: [ResourceType: ResourceInfo]
    
    init() {
        resourceInventory = [
            .hemp: ResourceInfo(quantity: 0, imageFile: "hemp-resource", rarity: .common),
            .corn: ResourceInfo(quantity: 0, imageFile: "corn-resource", rarity: .rare),
            .beef: ResourceInfo(quantity: 0, imageFile: "beef-resource", rarity: .luxury),
            .water: ResourceInfo(quantity: 0, imageFile: "water-resource", rarity: .common),
            .thorum: ResourceInfo(quantity: 0, imageFile: "thorum-resource", rarity: .common),
            .goldDust: ResourceInfo(quantity: 0, imageFile: "gold-dust", rarity: .common),
        ]
    }
    
    mutating func addResource(rec: ResourceType) {
        resourceInventory[rec]!.quantity += 1
    }
}


//class Structure {
//    var name: String
//    var description: String
//
//}

