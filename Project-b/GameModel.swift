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
    private(set) var resourceInventory: [ResourceType: Int]
    var structures: [MapPos: BasicStructure] = [MapPos(r: 3, c: 3): FarmStructure()]
    private var money: Int = 10000
    
    init() {
        resourceInventory = [
            .hemp: 0,
            .corn: 0,
            .beef: 0,
            .water: 0,
            .thorum: 0,
            .goldDust: 0,
        ]
        
    }
    
    mutating func addResource(rec: ResourceType, quantity: Int) {
        resourceInventory[rec]! += quantity
    }
    
    mutating func addMoney(quantity: Int) {
        money += quantity
    }
    
    mutating func subMoney(quantity: Int) {
        money -= quantity
    }
    
    mutating func progressStages() {
        for mapPos in structures.keys {
            if var structure = (structures[mapPos]! as? AnimatedStructure) {
                structure.progressStage()
                self.structures[mapPos] = structure
            }
        }
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

