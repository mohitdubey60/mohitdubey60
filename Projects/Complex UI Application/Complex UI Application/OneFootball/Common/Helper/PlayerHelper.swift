//
//  PlayerHelper.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 25/09/22.
//

import Foundation

class PlayerHelper {
    class func groupPlayersByPosition(players: [PlayerModel]) -> [String : [PlayerModel]] {
        return Dictionary(grouping: players, by: { $0.position?.rawValue ?? "" })
    }
    
    class func groupGoalsByPlayer(goals: [MatchGoalModel]) -> [String : [MatchGoalModel]] {
        return Dictionary(grouping: goals, by: { $0.player?.id ?? "" })
    }
    
    class func groupBySubstitutes(substitutes: [PlayerSubstitutionModel]) -> [String : [PlayerSubstitutionModel]] {
        let list = substitutes.sorted(by: { $0.order ?? 0 < $1.order ?? 0 })
        return Dictionary(grouping: list, by: { $0.playerOut?.id ?? "" })
    }
    
    class func groupByCards(cards: [MatchCardModel]) -> [String : [MatchCardModel]] {
        let list = cards.sorted(by: { $0.order ?? 0 < $1.order ?? 0 })
        return Dictionary(grouping: list, by: { $0.player?.id ?? "" })
    }
    
    class func getFormationDivision(formation: Int) -> [Int] {
        let stringFormation = String(formation)
        var arrItems: [Int] = stringFormation.compactMap({ Int("\($0)") })
        arrItems.insert(1, at: 0)
        return arrItems
    }
}
