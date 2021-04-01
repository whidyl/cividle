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
    var structures: [MapPos:  AnimatedStructure] = [MapPos(3, 3): Farm(pos: MapPos(3, 3))]
    //TODO: Aesthetics/Happiness quantity: effects productivity?
    //TODO: Research points
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
}

struct MapPos: Hashable {
    let r: Int
    let c: Int
    
    init(_ r: Int, _ c: Int) {
        self.r = r
        self.c = c
    }
    
    static func == (lhs: MapPos, rhs: MapPos) -> Bool {
        return lhs.r == rhs.r && lhs.c == rhs.c
    }
}

protocol Watchable {
    var name: String { get }
    var description: String { get }
    var iconFile: String { get }
}
