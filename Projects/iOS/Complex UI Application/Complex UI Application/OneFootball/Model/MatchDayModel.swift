import Foundation

    // MARK: - MatchDayModel
class MatchDayModel: Codable {
    var match: MatchModel?
}

    // MARK: - Match
class MatchModel: Codable {
    var coverage: MatchCoverageModel?
    var competitionID, competitionName, seasonID, id: String?
    var matchdayID: String?
    var kickoff, endTimestamp: String?
    var minute: Int?
    var minuteDisplay: String?
    var attendance: Int?
    var stadium: MatchStadiumModel?
    var referee: MatchRefereeModel?
    var period: String?
    var scorehome, scoreaway, scorehomefirsthalf, scoreawayfirsthalf: Int?
    var lineupsConfirmed, hasHeadtohead: Bool?
    var teamhome, teamaway: MatchTeamModel?
    var cards: [MatchCardModel]?
    var goals: [MatchGoalModel]?
    var retractedGoals: [MatchGoalModel]?
    var retractedRedCards: [MatchCardModel]?
    var teamsStandings: TeamsStandingsModel?
    
    enum CodingKeys: String, CodingKey {
        case coverage
        case competitionID = "competitionId"
        case competitionName
        case seasonID = "seasonId"
        case id
        case matchdayID = "matchdayId"
        case kickoff, endTimestamp, minute
        case minuteDisplay = "minute_display"
        case attendance, stadium, referee, period, scorehome, scoreaway, scorehomefirsthalf, scoreawayfirsthalf
        case lineupsConfirmed = "lineups_confirmed"
        case hasHeadtohead = "has_headtohead"
        case teamhome, teamaway, cards, goals
        case retractedGoals = "retracted_goals"
        case retractedRedCards = "retracted_red_cards"
        case teamsStandings
    }
}

    // MARK: - Card
class MatchCardModel: Codable {
    var eventID, type: String?
    var minute: Int?
    var minuteDisplay: String?
    var order: Int?
    var player: PlayerModel?
    
    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case type, minute
        case minuteDisplay = "minute_display"
        case order, player
    }
}

    // MARK: - Player
class PlayerModel: Codable {
    var id, name, firstName, lastName: String?
    var nickName, teamID: String?
    var thumbnailSrc: String?
    var position: PlayerPosition?
    var positionTactical, number: Int?
    var rating: PlayerRatingModel?
    
    enum CodingKeys: String, CodingKey {
        case id, name, firstName, lastName, nickName
        case teamID = "teamId"
        case thumbnailSrc, position, positionTactical, number, rating
    }
}

enum PlayerPosition: String, Codable {
    case defender = "Defender"
    case forward = "Forward"
    case goalkeeper = "Goalkeeper"
    case midfielder = "Midfielder"
    case substitution = "Substitution"
}

    // MARK: - Rating
class PlayerRatingModel: Codable {
    var value: String?
    var grade: PlayerGrade?
}

enum PlayerGrade: String, Codable {
    case average = "AVERAGE"
    case high = "HIGH"
    case low = "LOW"
}

    // MARK: - Coverage
class MatchCoverageModel: Codable {
    var watchable, hasLiveScores, hasMinute: Bool?
    
    enum CodingKeys: String, CodingKey {
        case watchable
        case hasLiveScores = "has_live_scores"
        case hasMinute = "has_minute"
    }
}

    // MARK: - Goal
class MatchGoalModel: Codable {
    var eventID, type: String?
    var minute: Int?
    var minuteDisplay: String?
    var order: Int?
    var period, teamID: String?
    var player, assistingPlayer: PlayerModel?
    
    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case type, minute
        case minuteDisplay = "minute_display"
        case order, period
        case teamID = "teamId"
        case player
        case assistingPlayer = "assisting_player"
    }
}

    // MARK: - Referee
class MatchRefereeModel: Codable {
    var id, name: String?
}

    // MARK: - Stadium
class MatchStadiumModel: Codable {
    var id, name, city, country: String?
    var countryCode: String?
}

    // MARK: - TeamawayClass
class MatchTeamModel: Codable {
    var id, name: String?
    var formationLayout: Int?
    var formation: [PlayerModel]?
    var substitutions: [PlayerSubstitutionModel]?
    var bench: [PlayerModel]?
    var absentPlayers: [PlayerModel]?
    var colors: TeamColorsModel?
    var isDummy: Bool?
    var stats: TeamStatsModel?
}

    // MARK: - Colors
class TeamColorsModel: Codable {
    var crestMainColor, mainColor, shirtColorAway, shirtColorHome: String?
}

    // MARK: - Stats
class TeamStatsModel: Codable {
    var totalScoringAtt, ontargetScoringAtt, blockedScoringAtt, shotsHitPostOrBar: Int?
    var shotsFromInsidebox, shotsFromOutsidebox: Int?
    var shotAccuracy, possessionPercentage, duelsWonPercentage, duelsWonAirPercentage: String?
    var interception, totalOffside, cornerTaken, totalPass: Int?
    var longPassesPercent, accuratePassesPercent, accurateFwdZonePassesPercent, accurateBackZonePassesPercent: String?
    var totalCross: Int?
    var accurateCrossesPercent: String?
    var totalTackle: Int?
    var wonTacklePercent: String?
    var totalClearance, fkFoulLost, totalYelCard, totalRedCard: Int?
    var goals: Int?
}

    // MARK: - Substitution
class PlayerSubstitutionModel: Codable {
    var minute: Int?
    var minuteDisplay: String?
    var order: Int?
    var eventID: String?
    var playerIn, playerOut: PlayerModel?
    
    enum CodingKeys: String, CodingKey {
        case minute
        case minuteDisplay = "minute_display"
        case order
        case eventID = "eventId"
        case playerIn, playerOut
    }
}

    // MARK: - TeamsStandings
class TeamsStandingsModel: Codable {
    var tableColumns: [String]?
    var teamHome, teamAway: TeamModel?
}

    // MARK: - Team
class TeamModel: Codable {
    var team: MatchTeamRanking?
    var index, indexOld, indexHome, indexAway: Int?
    var indexChange: String?
    var type: Int?
    var typeName: String?
    
    enum CodingKeys: String, CodingKey {
        case team, index, indexOld, indexHome, indexAway, indexChange, type
        case typeName = "type_name"
    }
}

    // MARK: - TeamClass
class MatchTeamRanking: Codable {
    var id, name: String?
    var played, won, drawn, lost: Int?
    var goalsShot, goalsGot, diff, points: Int?
}
