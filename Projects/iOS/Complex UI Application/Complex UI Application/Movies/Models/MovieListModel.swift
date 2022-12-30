//
//  MovieListModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 04/08/22.
//

import Foundation

    // MARK: - MoviesListModel
class MoviesListModel: Codable {
    var items: [Item]?
    var errorMessage: String?
    
    init(items: [Item]?, errorMessage: String?) {
        self.items = items
        self.errorMessage = errorMessage
    }
}

    // MARK: - Item
class Item: Codable {
    var id, rank, rankUpDown, title: String?
    var fullTitle, year: String?
    var image: String?
    var crew, imDBRating, imDBRatingCount: String?
    
    enum CodingKeys: String, CodingKey {
        case id, rank, rankUpDown, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
    
    init(id: String?, rank: String?, rankUpDown: String?, title: String?, fullTitle: String?, year: String?, image: String?, crew: String?, imDBRating: String?, imDBRatingCount: String?) {
        self.id = id
        self.rank = rank
        self.rankUpDown = rankUpDown
        self.title = title
        self.fullTitle = fullTitle
        self.year = year
        self.image = image
        self.crew = crew
        self.imDBRating = imDBRating
        self.imDBRatingCount = imDBRatingCount
    }
}
