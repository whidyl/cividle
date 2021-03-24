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
    
    func progressStages() {
        model.progressStages()
    }
    
    func gainRandomResource() {
        model.addResource(rec: ResourceType.allCases.randomElement()!, quantity: 1)
    }
    
    func yieldTerrain(terrainType: TerrainType) -> ResourceType? {
        if let rec = Terrains[terrainType]!.generateResource() {
            model.addResource(rec: rec, quantity: 1)
            return rec
        }
        return nil
    }
    
    func tick() {
        for structure in structures.values {
            structure.onTick(model: &model)
        }
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
    
    var resourceInventory: [ResourceType: Int] {
        return model.resourceInventory
    }
    var structures: [MapPos: BasicStructure] {
        return model.structures
    }
    
}
