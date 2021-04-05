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
    
    //TODO: change to return tuple after modifying generateResource() to generate quantities somehow
    func yieldTerrain(terrainType: TerrainType) -> ResourceType? {
        if let rec = Terrains[terrainType]!.generateResource() {
            model.addResource(rec, 1)
            return rec
        }
        return nil
    }
    
    func tick() {
        for pos in structures.keys {
            structures[pos]?.onTick(model: &model) 
        }
    }
    
    func collectAllOfStructure(at pos: MapPos) -> Int {
        var totalCollected = 0
        if let structure = model.structures[pos] {
            for i in 0..<structure.storageSlots.count {
                totalCollected += model.structures[pos]!.collectAllOf(type: structure.storageSlots[i].resourceType)
            }
        }
        return totalCollected
    }
    
    // MARK: Access to model
    
    func structureAt(_ at: MapPos) -> AnimatedStructure? {
        return structures[at]
    }
    
    var terrainMap: TerrainMap {
        return model.terrainMap
    }
    
    var resourceInventory: [ResourceType: Int] {
        return model.resourceInventory
    }
    
    var structures: [MapPos: AnimatedStructure] { 
        return model.structures
    }
    
}
