//
//  Terrain.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/14/21.
//

import Foundation


struct TerrainInfo {
    var imageFile: String
    var overlay: String?
    var resourcePotential: [ResourceType]
    
    func generateResource() -> ResourceType? {
        if !resourcePotential.isEmpty {
            return resourcePotential.randomElement()!
        } else {
            return nil
        }
        
    }
    // var description
}

struct TerrainMap {
    var cols = 6
    var rows = 8
    private var data: Array<Array<TerrainType>>
    
    init() {
        
        let n = TerrainType.nothing
        let w = TerrainType.water
        let g = TerrainType.grass
        let m = TerrainType.mountain
        
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
    
    mutating func set(r: Int, c: Int, type: TerrainType) {
        data[r][c] = type
    }
    
    func at(_ r: Int, _ c: Int) -> TerrainType {
        return data[r][c]
    }
}

let Terrains: [TerrainType: TerrainInfo] = [
    .nothing: TerrainInfo(imageFile: "nothing", resourcePotential: []),
    .grass: TerrainInfo(imageFile: "grass", resourcePotential: [.beef, .beef, .hemp, .corn, .corn, .corn, .corn, .corn, .corn, .corn]),
    .water: TerrainInfo(imageFile: "water", resourcePotential: [.water]),
    .mountain: TerrainInfo(imageFile: "mountain", overlay:"mountainoverlay", resourcePotential: [.goldDust, .thorum, .thorum])
]

enum TerrainType {
    case nothing
    case grass
    case water
    case mountain
}
