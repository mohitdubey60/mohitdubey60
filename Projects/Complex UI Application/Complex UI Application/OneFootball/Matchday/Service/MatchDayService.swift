//
//  MatchDayService.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 25/09/22.
//

import Foundation

enum TeamSide {
    case home
    case away
}

protocol MatchDayService {
    func getMatchDay(completion: @escaping (MatchDayModel?) -> Void)
    func getFormationAndLayout(side: TeamSide, completion: @escaping (Int, [PlayerModel], [String : [PlayerModel]]) -> Void)
}

class MockMatchDayService: MatchDayService {
    private var matchDay: MatchDayModel? = nil
    
    
    func getMatchDay(completion: @escaping (MatchDayModel?) -> Void) {
        if let data: Data = try? FileOperations.readContentOfFile(name: "EngVsGerMatchDay"),
           let matchDayModel: MatchDayModel = try? JsonParser.parseJsonToObject(data: data){
            matchDay = matchDayModel
        }
        
        completion(matchDay)
    }
    
    private func getTeamPlayingDetails(team currentTeam: MatchTeamModel?, completion: @escaping (Int, [PlayerModel], [String : [PlayerModel]]) -> Void) {
        if let team = currentTeam, let fl = team.formationLayout, let playingTeam = team.formation?.sorted(by: { item1, item2 in
            item1.positionTactical ?? 0 < item2.positionTactical ?? 0
        }) {
            let groupedTeam = PlayerHelper.groupPlayersByPosition(players: playingTeam)
            completion(fl, playingTeam, groupedTeam)
            return
        }
        completion(0, [], [:])
        return

    }
    
    func getFormationAndLayout(side: TeamSide, completion: @escaping (Int, [PlayerModel], [String : [PlayerModel]]) -> Void) {
        switch side {
            case .home:
                getTeamPlayingDetails(team: matchDay?.match?.teamhome, completion: completion)
            case .away:
                getTeamPlayingDetails(team: matchDay?.match?.teamaway, completion: completion)
        }
    }
}
