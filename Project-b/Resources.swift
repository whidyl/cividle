//
//  Resources.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/18/21.
//



import Foundation

struct ResourceInfo: Hashable {
    let imageFile: String
    //TODO: value can increase somehow like with tourism?
    var value: Int
}

let Resources: [ResourceType: ResourceInfo] = [
    .hemp: ResourceInfo(imageFile: "hemp-resource", value: 1),
    .corn: ResourceInfo(imageFile: "corn-resource", value: 20),
    .beef: ResourceInfo(imageFile: "beef-resource", value: 1),
    .water: ResourceInfo(imageFile: "water-resource", value: 1),
    .thorum: ResourceInfo(imageFile: "thorum-resource", value: 1),
    .goldDust: ResourceInfo(imageFile: "gold-dust", value: 100),
]

enum ResourceType: CaseIterable {
    case hemp
    case beef
    case corn
    case goldDust
    case water
    case thorum
}

func resourceImageFileOf(_ resource: ResourceType) -> String {
    return Resources[resource]!.imageFile
}
