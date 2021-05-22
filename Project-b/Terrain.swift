//
//  Terrain.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/14/21.
//

import Foundation
import GameplayKit

//TODO: Terrain discovery. discovered bool? upgrade to discover more land?
//TODO: Special features such as oil?
//TODO: serialization
//TODO: load from json terrain map (convert from square to trapazoid)

struct TerrainInfo {
    var name: String
    var imageFile: String
    var overlay: String?
    var resourcePotential: [ResourceType]
    var allowsStructures: [StructureType] = [.Farm, .StarterVillage]
    
    func generateResource() -> ResourceType? {
        if !resourcePotential.isEmpty {
            return resourcePotential.randomElement()!
        } else {
            return nil
        }
        
    }
    //TODO: var description
}

struct TerrainMap {
    private(set) var cols = 10
    private(set) var rows = 25
    private var data: Array<Array<TerrainType>>
    
    init() {
        
        let n = TerrainType.nothing
        let w = TerrainType.water
        let g = TerrainType.grass
        let m = TerrainType.mountain
        
        data = [
            [n, n, n, n, n, n, n],
              [n, n, w, w, m, m, n],
                [n, n, w, g, g, g, n],
                  [n, w, g, g, g, g, n],
                    [n, w, g, g, m, g, n],
                      [n, g, g, m, w, n, n],
                        [w, g, g, n, n, n, n],
                          [w, w, n, n, n, n, n]
        ]
        
        data = generateMap()
    }
    
    mutating func set(_ pos: MapPos, _ terrain: TerrainType) {
        data[pos.r][pos.c] = terrain
    }
    
    func typeAt(_ pos: MapPos) -> TerrainType {
        return data[pos.r][pos.c]
    }
    
    func terrainInfoAt(_ pos: MapPos) -> TerrainInfo {
        return Terrains[typeAt(pos)]!
    }
    
    func generateMap() -> [Array<TerrainType>] {
        var result = [Array<TerrainType>](repeating: [TerrainType](repeating: TerrainType.nothing, count: cols ), count: rows)
        let perlin = GKPerlinNoiseSource()
        perlin.seed = Int32.random(in: 0...10000)
        let noise = GKNoiseMap.init(GKNoise(perlin), size: vector2(1000.0, 1000.0), origin: vector2(500.0, 500.0), sampleCount: vector2(1000, 1000), seamless: true)
        
        let midR = rows/2
        let midC = cols/2
        
        var grasses: [(Int, Int)] = []
        for r in 0..<rows {
            for c in 0..<cols {
                let dist = Float(sqrt(pow(Double((midR - r))/1.3, 2) + pow(Double((midC - c)), 2)))/7
                
                if noise.value(at: vector2(Int32(r*10), Int32(c*10)))-dist > -0.5 {
                    grasses.append((r, c))
                    result[r][c] = TerrainType.grass
                }
            }
        }
        
        //Remove waters within 2 of grasses
        
        func adj2(_ pos: (Int, Int)) -> [(Int, Int)] {
            let adjacencies = [(-1, 0), (0, 1), (1, 0), (0, -1), (1, -1), (-1, 1)]
            var res: [(Int, Int)] = []
            for adj in adjacencies {
                let sum = (pos.0 + adj.0, pos.1 + adj.1)
                if sum.0 < rows && sum.1 < cols && sum.0 > -1 && sum.1 > -1 {
                    res.append(sum)
                }
            }
            return res
        }
        
        for rc in grasses {
            for adj in adj2(rc) {
                if result[adj.0][adj.1] == TerrainType.nothing {
                    result[adj.0][adj.1] = TerrainType.water
                }
            }
        }
        
        return result
    }
}

var Terrains: [TerrainType: TerrainInfo] = [
    .nothing: TerrainInfo(name: "nothing", imageFile: "nothing", resourcePotential: [], allowsStructures: []),
    .grass: TerrainInfo(name: "Grass", imageFile: "grass", resourcePotential: [.beef, .beef, .hemp, .corn, .corn, .corn, .corn, .corn, .corn, .corn]),
    .water: TerrainInfo(name: "Water", imageFile: "water", resourcePotential: [.water], allowsStructures: []),
    .mountain: TerrainInfo(name: "Mountain", imageFile: "mountain", overlay:"mountainoverlay", resourcePotential: [.goldDust, .thorum, .thorum], allowsStructures: [])
]

enum TerrainType {
    case nothing
    case grass
    case water
    case mountain
}
