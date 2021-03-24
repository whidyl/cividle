//
//  Resources.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//

import Foundation

struct ResourceInfo: Hashable {
    var imageFile: String
    var rarity: Rarity
}

let Resources: [ResourceType: ResourceInfo] = [
    .hemp: ResourceInfo(imageFile: "hemp-resource", rarity: .rare),
    .corn: ResourceInfo(imageFile: "corn-resource", rarity: .common),
    .beef: ResourceInfo(imageFile: "beef-resource", rarity: .luxury),
    .water: ResourceInfo(imageFile: "water-resource", rarity: .common),
    .thorum: ResourceInfo(imageFile: "thorum-resource", rarity: .common),
    .goldDust: ResourceInfo(imageFile: "gold-dust", rarity: .luxury),
]

enum ResourceType: CaseIterable {
    case hemp
    case beef
    case corn
    case goldDust
    case water
    case thorum
}

enum Rarity {
    case common
    case rare
    case luxury
}
