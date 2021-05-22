//
//  GameModel.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//

// !use terrain generation techniques to gen a 2d grid of ints, then use it as a template
// !have a caravan that travels back and forth on a path to collect generated resources.

import Foundation
import Deque

struct GameModel {
    //TODO: persistant data, load terrain map from json
    //TODO: storage capacity
    
    private(set) var terrainMap = TerrainMap()
    private(set) var resourceInventory: [ResourceType: Int] = ResourceType.allCases.reduce(into: [ResourceType: Int]()) { $0[$1] = 0 } //dictionary of all resource types with 0 quantity
    var structures: [MapPos:  AnimatedStructure] = [MapPos(3, 4): Farm(pos: MapPos(3, 4)),
                                                    MapPos(2, 4): Farm(pos: MapPos(2, 4)),
                                                    MapPos(3, 3): StarterVillage(pos: MapPos(3, 3)),
                                                    MapPos(1, 3): Farm(pos: MapPos(1, 3))]
    var indicators = [MapPos: Deque<TapIndicator>]()
    //!Aesthetics/Happiness; quantity effects productivity?
    //TODO: Research points
    var purchasableStructures: [AnimatedStructure] = [StarterVillage(pos: MapPos(0, 0)), Farm(pos: MapPos(0, 0))]
    private(set) var money: Int = 10000
    
    mutating func addResource(_ resourceType: ResourceType, _ quantity: Int) {
        resourceInventory[resourceType]! += quantity
    }
    
    mutating func addMoney(_ quantity: Int) {
        money += quantity
    }
    
    mutating func subtractMoney(_ quantity: Int) {
        money -= quantity
    }
    
    mutating func sellResources() {
        for (type, quantity) in resourceInventory {
            money += Resources[type]!.value*quantity
            resourceInventory = ResourceType.allCases.reduce(into: [ResourceType: Int]()) { $0[$1] = 0 }
        }
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
    
    static func + (lhs: MapPos, rhs: MapPos) -> MapPos {
        return MapPos(lhs.r + rhs.r, lhs.c + rhs.c)
    }
    
    func adjacent() -> [MapPos] {
        var adj = [MapPos]()
        for dir in axialDirections { adj.append(self + dir) }
        return adj
    }
}

fileprivate let axialDirections = [MapPos(1, 0), MapPos(1, -1), MapPos(0, -1), MapPos(-1, 0), MapPos(-1, 1), MapPos(0, 1)]

protocol Watchable {
    var name: String { get }
    var description: String { get }
    var iconFile: String { get }
}
