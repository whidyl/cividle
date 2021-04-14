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
        for kv in structures.sorted(by: {$0.value.tickPriority > $1.value.tickPriority}) {
            structures[kv.0]?.onTick(model: &model)
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
    
    func getStructureIndicators(pos: MapPos) -> [(ResourceType, Int)] {
        if let indicators = structures[pos]?.indicators {
            model.structures[pos]?.indicators = []
            return indicators
        }
        return []
    }
    
    func purchaseStructure(type: StructureType, pos: MapPos) {
        //TODO: money validation
        //TODO: visual indication of invalid purchase location
        if model.terrainMap.terrainInfoAt(pos).allowsStructures.contains(type) && model.structures[pos] == nil{
            switch type {
            case .StarterVillage:
                    model.structures[pos] = StarterVillage(pos: pos)
            case .Farm:
                    model.structures[pos] = Farm(pos: pos)
            }
            model.structures[pos]?.onPlace(model: &model)
        }
    }
    
    func sellStructure(pos: MapPos) {
        model.structures[pos]?.onRemove(model: &model)
        model.structures[pos] = nil
    }
    
    func sellGoods() {
        model.sellResources()
    }
    
    // MARK: Access to model
    
    func structureAt(_ at: MapPos) -> AnimatedStructure? {
        return structures[at]
    }
    
    var purchasableStructures: [AnimatedStructure] {
        return model.purchasableStructures
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
    
    var money: Int {
        return model.money
    }
    
}
