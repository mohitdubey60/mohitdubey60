//
//  PlayerOnPitchViewModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 27/09/22.
//

import Foundation

class PlayerOnPitchViewModel {
    var player: PlayerModel
    var goals: [MatchGoalModel]
    var substitute: PlayerSubstitutionModel?
    var cards: [MatchCardModel]
    
    init(player: PlayerModel, goals: [MatchGoalModel], substitute: PlayerSubstitutionModel?, cards: [MatchCardModel]) {
        self.player = player
        self.goals = goals
        self.substitute = substitute
        self.cards = cards
    }
}
