//
//  LineupViewModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 26/09/22.
//

import Foundation

class LineupViewModel {
    var team: MatchTeamModel
    var formation: Int
    var players: [PlayerModel]
    let groupedGoalsByPlayers: [String : [MatchGoalModel]]
    var groupedFormation: [String : [PlayerModel]]
    var groupedSubstitution: [String : [PlayerSubstitutionModel]] = [:]
    var groupedCardsByPlayer: [String : [MatchCardModel]] = [:]
    
    init(team: MatchTeamModel, formation: Int, players: [PlayerModel], groupedGoalsByPlayers: [String : [MatchGoalModel]], groupedFormation: [String : [PlayerModel]], groupedSubstitution: [String : [PlayerSubstitutionModel]], groupedCardsByPlayer: [String : [MatchCardModel]]) {
        self.team = team
        self.formation = formation
        self.players = players
        self.groupedGoalsByPlayers = groupedGoalsByPlayers
        self.groupedFormation = groupedFormation
        self.groupedSubstitution = groupedSubstitution
        self.groupedCardsByPlayer = groupedCardsByPlayer
    }
}
