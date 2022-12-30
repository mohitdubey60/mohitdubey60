//
//  MatchDayViewModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 26/09/22.
//

import Foundation

class MatchDayViewModel {
    let service: MatchDayService
    var lineupViewModel: LineupViewModel?
    var matchDayModel: MatchDayModel?
    var groupedGoalsByPlayer: [String : [MatchGoalModel]] = [:]
    var groupedCardsByPlayer: [String : [MatchCardModel]] = [:]
    
    init(service: MatchDayService) {
        self.service = service
    }
    
    private func goalsByPlayers() {
        if let goals = matchDayModel?.match?.goals {
            groupedGoalsByPlayer = PlayerHelper.groupGoalsByPlayer(goals: goals)
        }
    }
    
    private func cardsByPlayers() {
        if let cards = matchDayModel?.match?.cards {
            groupedCardsByPlayer = PlayerHelper.groupByCards(cards: cards)
        }
    }
    
    func getMatchDayData(completion: @escaping () -> Void) {
        service.getMatchDay {[weak self] matchDayItem in
            guard let `self` = self else {
                return
            }
            
            self.matchDayModel = matchDayItem
            self.goalsByPlayers()
            self.cardsByPlayers()
            
            completion()
        }
    }
    
    func getFormationDetails(side: TeamSide, completion: @escaping () -> Void) {
        service.getFormationAndLayout(side: side) {[weak self] formation, players, groupedPlayers in
            guard let `self` = self else {
                return
            }
            let substitutes = (side == .home ? self.matchDayModel?.match?.teamhome : self.matchDayModel?.match?.teamaway)?.substitutions ?? []
            let groupedSubstitutes = PlayerHelper.groupBySubstitutes(substitutes: substitutes)
            if let team = side == .home ? self.matchDayModel?.match?.teamhome : self.matchDayModel?.match?.teamaway {
                self.lineupViewModel = LineupViewModel(team: team, formation: formation, players: players, groupedGoalsByPlayers: self.groupedGoalsByPlayer, groupedFormation: groupedPlayers, groupedSubstitution: groupedSubstitutes, groupedCardsByPlayer: self.groupedCardsByPlayer)
            }
            completion()
        }
    }
}
