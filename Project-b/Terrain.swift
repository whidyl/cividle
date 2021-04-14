//
//  Terrain.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/14/21.
//

import Foundation

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
    private(set) var cols = 7
    private(set) var rows = 8
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
