//
//  MatchCommentaryModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 24/09/22.
//
import Foundation

    // MARK: - MatchCommentaryModel
class MatchCommentaryModel: Codable {
    var meta: MatchMetaModel?
    var comments: [MatchCommentModel]?
}

    // MARK: - Comment
class MatchCommentModel: Codable {
    var commentID: String?
    var type: MatchEventTypeEnum?
    var lastmodified, minute: Int?
    var minuteDisplay, comment: String?
    var sortID: Int?
    var matchID, matchdayID: String?
    var eventTime: String?
    var eventTeam, player1ID: String?
    var player1PhotoSrc: String?
    var player2ID: String?
    var player2PhotoSrc: String?
    var provider: MatchProvider?
    var player1TeamID, player2TeamID: Int?
    var player1InternalTeamID, player1Number, player1Name, player2InternalTeamID: String?
    var player2Number, player2Name: String?
    
    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case type, lastmodified, minute
        case minuteDisplay = "minute_display"
        case comment
        case sortID = "sortId"
        case matchID = "matchId"
        case matchdayID = "matchdayId"
        case eventTime, eventTeam
        case player1ID = "player1Id"
        case player1PhotoSrc
        case player2ID = "player2Id"
        case player2PhotoSrc, provider
        case player1TeamID = "player1TeamId"
        case player2TeamID = "player2TeamId"
        case player1InternalTeamID = "player1InternalTeamId"
        case player1Number
        case player1Name = "player1_name"
        case player2InternalTeamID = "player2InternalTeamId"
        case player2Number
        case player2Name = "player2_name"
    }
}

enum MatchProvider: String, Codable {
    case perform = "perform"
}

enum MatchEventTypeEnum: String, Codable {
    case goal = "goal"
    case other = "other"
    case startEnd = "startEnd"
    case substitution = "substitution"
    case yellowCard = "yellowCard"
}

    // MARK: - Meta
class MatchMetaModel: Codable {
    var competitionID, seasonID, matchdayID, matchID: String?
    var provider: MatchProvider?
    var teamHomeIDS, teamAwayIDS, teamHomeInternalIDS, teamAwayInternalIDS: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case competitionID = "competitionId"
        case seasonID = "seasonId"
        case matchdayID = "matchdayId"
        case matchID = "matchId"
        case provider
        case teamHomeIDS = "teamHomeIds"
        case teamAwayIDS = "teamAwayIds"
        case teamHomeInternalIDS = "teamHomeInternalIds"
        case teamAwayInternalIDS = "teamAwayInternalIds"
    }
}

class MatchOverviewModel: Codable {
    var meta: MatchMetaModel?
    var preview: MatchPreviewModel?
}

    // MARK: - Preview
class MatchPreviewModel: Codable {
    var id, language, editorial: String?
    var date: String?
    var headline: String?
}
