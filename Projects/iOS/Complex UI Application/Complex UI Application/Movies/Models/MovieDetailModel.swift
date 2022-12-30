//
//  MovieDetailModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 04/08/22.
//

import Foundation

    // MARK: - MoviesDetailModel
class MoviesDetailModel: Codable {
    var id, title, originalTitle, fullTitle: String?
    var type, year: String?
    var image: String?
    var releaseDate: String?
//    var runtimeMins, runtimeStr: JSONNull?
    var plot, plotLocal: String?
    var plotLocalIsRTL: Bool?
    var awards, directors: String?
    var directorList: [CompanyListElement]?
    var writers: String?
    var writerList: [CompanyListElement]?
    var stars: String?
    var starList: [CompanyListElement]?
    var actorList: [ActorList]?
//    var fullCast: JSONNull?
    var genres: String?
    var genreList: [CountryListElement]?
    var companies: String?
    var companyList: [CompanyListElement]?
    var countries: String?
    var countryList: [CountryListElement]?
    var languages: String?
    var languageList: [CountryListElement]?
//    var contentRating, imDBRating, imDBRatingVotes, metacriticRating: JSONNull?
//    var ratings, wikipedia, posters, images: JSONNull?
//    var trailer: JSONNull?
    var boxOffice: BoxOffice?
//    var tagline: JSONNull?
    var keywords: String?
    var keywordList: [String]?
    var similars: [Similar]?
//    var tvSeriesInfo, tvEpisodeInfo, errorMessage: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id, title, originalTitle, fullTitle, type, year, image, releaseDate, plot, plotLocal
        case plotLocalIsRTL = "plotLocalIsRtl"
        case awards, directors, directorList, writers, writerList, stars, starList, actorList, genres, genreList, companies, companyList, countries, countryList, languages, languageList
//        case imDBRating = "imDbRating"
//        case imDBRatingVotes = "imDbRatingVotes"
        case boxOffice, keywords, keywordList, similars
//        case runtimeMins, runtimeStr, fullCast, contentRating, metacriticRating, ratings, wikipedia, posters, images, tvSeriesInfo, tvEpisodeInfo, errorMessage, tagline, trailer
    }
    
//    init(id: String?, title: String?, originalTitle: String?, fullTitle: String?, type: String?, year: String?, image: String?, releaseDate: String?, runtimeMins: JSONNull?, runtimeStr: JSONNull?, plot: String?, plotLocal: String?, plotLocalIsRTL: Bool?, awards: String?, directors: String?, directorList: [CompanyListElement]?, writers: String?, writerList: [CompanyListElement]?, stars: String?, starList: [CompanyListElement]?, actorList: [ActorList]?, fullCast: JSONNull?, genres: String?, genreList: [CountryListElement]?, companies: String?, companyList: [CompanyListElement]?, countries: String?, countryList: [CountryListElement]?, languages: String?, languageList: [CountryListElement]?, contentRating: JSONNull?, imDBRating: JSONNull?, imDBRatingVotes: JSONNull?, metacriticRating: JSONNull?, ratings: JSONNull?, wikipedia: JSONNull?, posters: JSONNull?, images: JSONNull?, trailer: JSONNull?, boxOffice: BoxOffice?, tagline: JSONNull?, keywords: String?, keywordList: [String]?, similars: [Similar]?, tvSeriesInfo: JSONNull?, tvEpisodeInfo: JSONNull?, errorMessage: JSONNull?) {
//        self.id = id
//        self.title = title
//        self.originalTitle = originalTitle
//        self.fullTitle = fullTitle
//        self.type = type
//        self.year = year
//        self.image = image
//        self.releaseDate = releaseDate
////        self.runtimeMins = runtimeMins
////        self.runtimeStr = runtimeStr
//        self.plot = plot
//        self.plotLocal = plotLocal
//        self.plotLocalIsRTL = plotLocalIsRTL
//        self.awards = awards
//        self.directors = directors
//        self.directorList = directorList
//        self.writers = writers
//        self.writerList = writerList
//        self.stars = stars
//        self.starList = starList
//        self.actorList = actorList
////        self.fullCast = fullCast
//        self.genres = genres
//        self.genreList = genreList
//        self.companies = companies
//        self.companyList = companyList
//        self.countries = countries
//        self.countryList = countryList
//        self.languages = languages
//        self.languageList = languageList
////        self.contentRating = contentRating
////        self.imDBRating = imDBRating
////        self.imDBRatingVotes = imDBRatingVotes
////        self.metacriticRating = metacriticRating
////        self.ratings = ratings
////        self.wikipedia = wikipedia
////        self.posters = posters
////        self.images = images
////        self.trailer = trailer
//        self.boxOffice = boxOffice
////        self.tagline = tagline
//        self.keywords = keywords
//        self.keywordList = keywordList
//        self.similars = similars
////        self.tvSeriesInfo = tvSeriesInfo
////        self.tvEpisodeInfo = tvEpisodeInfo
////        self.errorMessage = errorMessage
//    }
}

    // MARK: - ActorList
class ActorList: Codable {
    var id: String?
    var image: String?
    var name, asCharacter: String?
    
    init(id: String?, image: String?, name: String?, asCharacter: String?) {
        self.id = id
        self.image = image
        self.name = name
        self.asCharacter = asCharacter
    }
}

    // MARK: - BoxOffice
class BoxOffice: Codable {
    var budget, openingWeekendUSA, grossUSA, cumulativeWorldwideGross: String?
    
    init(budget: String?, openingWeekendUSA: String?, grossUSA: String?, cumulativeWorldwideGross: String?) {
        self.budget = budget
        self.openingWeekendUSA = openingWeekendUSA
        self.grossUSA = grossUSA
        self.cumulativeWorldwideGross = cumulativeWorldwideGross
    }
}

    // MARK: - CompanyListElement
class CompanyListElement: Codable {
    var id, name: String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

    // MARK: - CountryListElement
class CountryListElement: Codable {
    var key, value: String?
    
    init(key: String?, value: String?) {
        self.key = key
        self.value = value
    }
}

    // MARK: - Similar
class Similar: Codable {
    var id, title: String?
    var image: String?
    var imDBRating: IMDBRating?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image
        case imDBRating = "imDbRating"
    }
    
    init(id: String?, title: String?, image: String?, imDBRating: IMDBRating?) {
        self.id = id
        self.title = title
        self.image = image
        self.imDBRating = imDBRating
    }
}

enum IMDBRating: String, Codable {
    case empty = ""
    case the57 = "5.7"
    case the73 = "7.3"
}

    // MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//
