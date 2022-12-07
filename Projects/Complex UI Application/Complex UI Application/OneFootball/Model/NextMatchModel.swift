    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let nextMatchModel = try? newJSONDecoder().decode(NextMatchModel.self, from: jsonData)

import Foundation

    // MARK: - NextMatchModel
class NextMatchModel: Codable {
    var matches: [NextMatchMatchModel]?
}

    // MARK: - Match
class NextMatchMatchModel: Codable {
    var id: Int?
    var kickoff: String?
    var scoreHome, scoreAway: Int?
    var teamHome, teamAway: NextMatchTeamModel?
    var competition: NextMatchCompetitionModel?
    var season: NextMatchSeasonModel?
    var matchday: NextMatchMatchdayModel?
    var groupName: String?
    var minute: Int?
    var minuteDisplay, period: String?
    var scoreHomeFirstHalf, scoreAwayFirstHalf: Int?
    var coverage: NextMatchCoverageModel?
    
    enum CodingKeys: String, CodingKey {
        case id, kickoff
        case scoreHome = "score_home"
        case scoreAway = "score_away"
        case teamHome = "team_home"
        case teamAway = "team_away"
        case competition, season, matchday
        case groupName = "group_name"
        case minute
        case minuteDisplay = "minute_display"
        case period
        case scoreHomeFirstHalf = "score_home_first_half"
        case scoreAwayFirstHalf = "score_away_first_half"
        case coverage
    }
}

    // MARK: - Competition
class NextMatchCompetitionModel: Codable {
    var id: Int?
    var name: String?
}

    // MARK: - Coverage
class NextMatchCoverageModel: Codable {
    var hasLiveScores, hasMinute: Bool?
    
    enum CodingKeys: String, CodingKey {
        case hasLiveScores = "has_live_scores"
        case hasMinute = "has_minute"
    }
}

    // MARK: - Matchday
class NextMatchMatchdayModel: Codable {
    var id: Int?
    var name: String?
    var number: Int?
}

    // MARK: - Season
class NextMatchSeasonModel: Codable {
    var id: Int?
}

    // MARK: - Team
class NextMatchTeamModel: Codable {
    var id: Int?
    var name: String?
    var isNational: Bool?
    var country: Country?
    var colors: [Color]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isNational = "is_national"
        case country, colors
    }
}

    // MARK: - Color
class Color: Codable {
    var name, value: String?
}

    // MARK: - Country
class Country: Codable {
    var name, code: String?
}
