//
//  GameModel.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//

// !use terrain generation techniques to gen a 2d grid of ints, then use it as a template

import Foundation

struct GameModel {
    
    
    private(set) var cols = 6
    private(set) var rows = 8
    private(set) var  terrainMap: Array<Array<Terrain>>
    private(set) var hand: Array<Card> = [Cards["discover grass"]!, Cards["discover grass"]!, Cards["discover water"]!, Cards["discover grass"]!, Cards["discover mountain"]!, Cards["discover water"]!]
    
    init() {
        
        let n = TerrainTypes["nothing"]!
        let w = TerrainTypes["water"]!
        let g = TerrainTypes["grass"]!
        let m = TerrainTypes["mountain"]!
        var m2 = m
        m2.overlay = nil
        
        terrainMap = [
        [n, n, n, n, n, n],
          [n, n, n, w, n, n],
            [n, n, w, g, g, n],
              [n, w, g, g, g, n],
                [n, w, g, g, m, n],
                  [n, n, m2, n, n, n],
                    [n, n, n, n, n, n],
                      [n, n, n, n, n, n]
        ]
    }
    
    mutating func setTerrain(r: Int, c: Int, terrain: Terrain) {
        terrainMap[r][c] = terrain
    }
    
    mutating func removeCard(at: Int) {
        if (at < hand.count) {
            hand.remove(at: at)
        }
    }
}

let TerrainTypes = [
    "nothing": Terrain(name: "nothing"),
    "grass": Terrain(name: "grass"),
    "water": Terrain(name: "water"),
    "mountain": Terrain(name: "mountain", overlay: "mountainoverlay")
]

let Cards = [
    "discover grass": Card(name: "discover grass", image: "grass") { (model: inout GameModel, r: Int, c: Int) in
        model.setTerrain(r: r, c: c, terrain: TerrainTypes["grass"]!)
    },
    
    "discover mountain": Card(name: "discover mountain", image: "mountainoverlay") { (model: inout GameModel, r: Int, c: Int) in
        model.setTerrain(r: r, c: c, terrain: TerrainTypes["mountain"]!)
    },
    
    "discover water": Card(name: "discover water", image: "water") { (model: inout GameModel, r: Int, c: Int) in
        model.setTerrain(r: r, c: c, terrain: TerrainTypes["water"]!)
    },
]

struct Terrain {
    var name: String
    var overlay: String?
    // var description
    // var resources: use and array of sets for Resource object (with members type(enum), and quantity)
}

struct Card {
    var name: String
    var image: String
    var targetedAction: (inout GameModel, Int, Int) -> Void
}

//class Structure {
//    var name: String
//    var description: String
//
//}

