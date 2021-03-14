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
    
    func playCard(card: Card, r: Int, c: Int) {
        model.removeCard(at: 0)
        card.targetedAction(&model, r, c)
    }
    
    // MARK: Access to model
    var map: Array<Array<Terrain>> {
        return model.terrainMap
    }
    
    var cols: Int {
        return model.cols
    }
    
    var rows: Int {
        return model.rows
    }
    
    var hand: Array<Card> {
        return model.hand 
    }
}
