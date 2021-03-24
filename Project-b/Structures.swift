//
//  Structures.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/19/21.
//

import Foundation

//var Structures: [StructureType: Structure] = [
//    .farm: Structure(
//        name: "Farm",
//        maxStage: 3,
//        imageFiles: [
//            0: "farm-stage1",
//            1: "farm-stage2",
//            2: "farm-stage3",
//            3: "farm-stage4",
//        ],
//        onPlace: { model in
//            model.addResource(rec: .goldDust, quantity: 100)
//        },
//        onTick: { model in
//            model.addResource(rec: .corn, quantity: 5)
//        },
//        onRemove: {model in
//            model.addResource(rec: .water, quantity: 5)
//        }
//    )
//]

struct FarmStructure: AnimatedStructure {
    
    var stage: Int = 0
    var maxStage: Int = 3
    
    var imageFiles = [
                0: "farm-stage1",
                1: "farm-stage2",
                2: "farm-stage3",
                3: "farm-stage4",
            ]
    
    let id = UUID()
    var name: String = "Farm"
    
    func onPlace(model: inout GameModel) {
        model.subMoney(quantity: 1000)
    }
    
    func onTick(model: inout GameModel) {
        if stage == 0 {
            model.addResource(rec: .corn, quantity: 1)
        }
    }
    
    func onRemove(model: inout GameModel) {
        model.addMoney(quantity: 1000)
    }
    
    
}

protocol BasicStructure {
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


