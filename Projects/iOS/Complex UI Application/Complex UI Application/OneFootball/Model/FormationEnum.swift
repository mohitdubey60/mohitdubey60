//
//  FormationEnum.swift
//  OneFootballMock
//
//  Created by mohit dubey on 12/09/21.
//

import Foundation

enum FormationEnum: Int {
    case threeFiveTwo = 352
    case threeOneFourTwo = 3142
    case threeFourTwoOne = 3421
    case threeFourOneTwo = 3412
    case threeFourThree = 343
    case threeFiveOneOne = 3511
    case fourOneTwoOneTwo = 41212
    case fourOneThreeTwo = 4132
    case fourOneFourOne = 4141
    case fourTwoTwoTwo = 4222
    case fourThreeTwoOne = 4321
    case fourTwoThreeOne = 4231
    case fourTwoFour = 424
    case fourThreeOneTwo = 4312
    case fourThreeThree = 433
    case fourFourOneOne = 4411
    case fourFourTwo = 442
    case fourFiveOne = 451
    case fiveTwoOneTwo = 5212
    case fiveTwoTwoOne = 5221
    case fiveTwoThree = 523
    case fiveThreeTwo = 532
    case fiveFourOne = 541
    
    var vertical: Int {
        switch self {
            case .threeFiveTwo, .threeFiveOneOne, .fourFiveOne, .fiveTwoOneTwo, .fiveTwoTwoOne, .fiveTwoThree, .fiveThreeTwo, .fiveFourOne:
                return 5
            case .threeOneFourTwo, .threeFourTwoOne, .threeFourOneTwo, .threeFourThree, .fourOneTwoOneTwo, .fourOneThreeTwo, .fourOneFourOne, .fourTwoTwoTwo, .fourThreeTwoOne, .fourTwoThreeOne, .fourTwoFour, .fourThreeOneTwo, .fourThreeThree, .fourFourOneOne, .fourFourTwo:
                return 4
        }
    }
}
