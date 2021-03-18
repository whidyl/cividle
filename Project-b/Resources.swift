//
//  Resources.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//

import Foundation

struct ResourceInfo: Hashable {
    var quantity: Int
    var imageFile: String
    var rarity: Rarity
}

let ResourceImageFileNames: [ResourceType: String] = [
    .hemp: "hemp-resource",
    .corn: "corn-resource",
    .beef: "beef-resource",
    .water: "water-resource",
    .thorum: "thorum-resource",
    .goldDust: "gold-dust"
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
