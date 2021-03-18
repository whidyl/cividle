//
//  GameViewModel.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/4/21.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var model: GameModel = GameModel()
    
    // MARK: Intent(s)
    
    func setGrass(r: Int, c: Int) {
        model.terrainMap.setTerrain(r: r, c: c, terrain: TerrainTypes[.grass]!)
    }
    
    func gainRandomResource() {
        model.addResource(rec: ResourceType.allCases.randomElement()!)
    }
    
    func yieldTerrain(terrain: Terrain) -> ResourceType? {
        if let rec = terrain.resourceGenerator() {
            model.addResource(rec: rec)
            return rec
        }
        return nil
    }
    
    // MARK: Access to model
    var map: TerrainMap {
        return model.terrainMap
    }
    
    var cols: Int {
        return model.terrainMap.cols
    }
    
    var rows: Int {
        return model.terrainMap.rows
    }
    
    var resourseInventory: [ResourceType: ResourceInfo] {
        return model.resourceInventory
    }
    
}
