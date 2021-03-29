//
//  GameModel.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//

// !use terrain generation techniques to gen a 2d grid of ints, then use it as a template

import Foundation

struct GameModel {
    //TODO: persistant data, load terrain map from json
    private(set) var terrainMap = TerrainMap()
    private(set) var resourceInventory: [ResourceType: Int] = ResourceType.allCases.reduce(into: [ResourceType: Int]()) { $0[$1] = 0 } //dictionary of all resource types with 0 quantity
    var structures: [MapPos: AnimatedStructure] = [MapPos(r: 3, c: 3): FarmStructure(pos: MapPos(r: 3, c: 3))]
    //TODO: Aesthetics/Happiness quantity: effects productivity?
    private var money: Int = 10000
    
    mutating func addResource(_ resourceType: ResourceType, _ quantity: Int) {
        resourceInventory[resourceType]! += quantity
    }
    
    mutating func addMoney(_ quantity: Int) {
        money += quantity
    }
    
    mutating func subtractMoney(_ quantity: Int) {
        money -= quantity
    }
    
    func tick() {
        
    }
}

struct MapPos: Hashable {
    let r: Int
    let c: Int
    
    static func == (lhs: MapPos, rhs: MapPos) -> Bool {
        return lhs.r == rhs.r && lhs.c == rhs.c
    }
}

protocol Watchable {
    var name: String { get }
    var description: String { get }
    var iconFile: String { get }
}
