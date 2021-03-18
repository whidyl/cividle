//
//  Terrain.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/14/21.
//

import Foundation


struct Terrain {
    var name: String
    var overlay: String?
    //var resourceYield: [ResourceType]
    var resourceGenerator: () -> ResourceType?
    // var description
}

struct TerrainMap {
    var cols = 6
    var rows = 8
    var data: Array<Array<Terrain>>
    
    init() {
        
        let n = TerrainTypes[.nothing]!
        let w = TerrainTypes[.water]!
        let g = TerrainTypes[.grass]!
        let m = TerrainTypes[.mountain]!
        
        data = [
        [n, n, n, n, n, n],
          [n, n, n, w, n, n],
            [n, n, w, g, g, n],
              [n, w, g, g, g, n],
                [n, w, g, g, m, n],
                  [n, n, m, n, n, n],
                    [n, n, n, n, n, n],
                      [n, n, n, n, n, n]
        ]
    }
    
    mutating func setTerrain(r: Int, c: Int, terrain: Terrain) {
        data[r][c] = terrain
    }
}

let TerrainTypes: [TerrainType: Terrain] = [ 
    .nothing: Terrain(name: "nothing") {
        return nil
    },
    .grass: Terrain(name: "grass") {
        let rand = Float.random(in: 0..<1)
        if (rand < 0.1) {
            return ResourceType.beef
        } else if (rand < 0.4) {
            return ResourceType.hemp
        } else {
            return ResourceType.corn
        }
    },
    .water: Terrain(name: "water") {
        return ResourceType.water
    },
    .mountain: Terrain(name: "mountain", overlay: "mountainoverlay") {
        let rand = Float.random(in: 0..<1)
        if (rand < 0.1) {
            return ResourceType.goldDust
        } else {
            return ResourceType.thorum
        }
    }
]

enum TerrainType {
    case nothing
    case grass
    case water
    case mountain
}
