//
//  Structures.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/19/21.
//

import Foundation
//TODO: structures hold one resource and a quantity until tapped or consumed by adjacent structure
struct FarmStructure: AnimatedStructure {
    
    var stage: Int = 0
    var maxStage: Int = 3
    var pos: MapPos
    
    var imageFiles = [
                0: "farm-stage1",
                1: "farm-stage2",
                2: "farm-stage3",
                3: "farm-stage4",
            ]
    
    let id = UUID()
    var name: String = "Farm"
    var description: String = "Collects food, must be placed on water"
    var iconFile: String = "farm-stage4"
    
    func onPlace(model: inout GameModel) {
        model.subtractMoney(1000)
    }
    
    func onTick(model: inout GameModel) {
        model.structures[pos]!.progressStage()
        if stage == 3 {
            model.addResource(.corn, 1)
        }
    }
    
    func onRemove(model: inout GameModel) {
        model.addMoney(1000)
    }
    
    
}

protocol BasicStructure: Watchable {
    var id: UUID { get }
    var name: String { get }
    var imageFile: String { get }
    func onPlace (model: inout GameModel) -> Void
    func onTick (model: inout GameModel) -> Void
    func onRemove (model: inout GameModel) -> Void
}

protocol StorageStructure: BasicStructure {
    var internalStorage: [ResourceType: Int] { get set }
    func storeResource (type: ResourceType, quantity: Int) -> Void
    //TODO: func popResources
}

protocol AnimatedStructure: BasicStructure {
    var stage: Int { get set }
    var maxStage: Int { get }
    var imageFiles: [Int: String] { get }
    mutating func progressStage() -> Void
}

extension AnimatedStructure {
    mutating func progressStage() {
        if stage < maxStage {
            self.stage += 1
        } else {
            self.stage = 0
        }
    }
    
    var imageFile: String { return imageFiles[stage]! }
}


