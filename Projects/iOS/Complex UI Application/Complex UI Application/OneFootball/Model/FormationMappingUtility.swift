//
//  FormationMappingUtility.swift
//  OneFootballMock
//
//  Created by mohit dubey on 12/09/21.
//

import Foundation

struct FormationMappingUtility {
    static let formationMapping: [FormationEnum: [PositionEnum]] = [
        .threeFiveTwo: [.gk, .rcb, .cb, .lcb, .rm, .rcm, .cm, .lcm, .lm, .rst, .lst],
        .threeOneFourTwo: [.gk, .rcb, .cb, .lcb, .rm, .rcm, .cdm, .lcm, .lm, .rst, .lst],
        .threeFourOneTwo: [.gk, .rcb, .cb, .lcb, .rm, .rcm, .lcm, .lm, .cam, .rst, .lst],
        .threeFourTwoOne: [.gk, .rcb, .cb, .lcb, .rm, .rcm, .lcm, .lm, .rf, .lf, .st],
        .threeFourThree: [.gk, .rcb, .cb, .lcb, .rm, .rcm, .lcm, .lm,  .rw, .st, .lw],
        .threeFiveOneOne: [.gk, .rcb, .cb, .lcb, .rm, .rcm, .cdm, .lcm, .lm, .cam, .st],
        .fourOneTwoOneTwo: [.gk, .rb, .rcb, .lcb, .lb, .cdm, .rcm, .lcm, .cam, .rst, .lst],
        .fourOneThreeTwo: [.gk, .rb, .rcb, .lcb, .lb, .cdm, .rm, .cm, .lm, .rst, .lst],
        .fourOneFourOne: [.gk, .rb, .rcb, .lcb, .lb, .cdm, .rm, .rcm, .lcm, .lm, .st],
        .fourTwoTwoTwo: [.gk, .rb, .rcb, .lcb, .lb, .rcdm, .lcdm, .ram, .lam, .rst, .lst],
        .fourThreeTwoOne: [.gk, .rb, .rcb, .lcb, .lb, .rcm, .cm, .lcm, .rf, .lf, .st],
        .fourTwoThreeOne: [.gk, .rb, .rcb, .lcb, .lb, .rcdm, .lcdm, .ram, .cam, .lam, .st],
        .fourTwoFour: [.gk, .rb, .rcb, .lcb, .lb, .rcm, .lcm, .rw, .rst, .lst, .lw],
        .fourThreeOneTwo: [.gk, .rb, .rcb, .lcb, .lb, .rm, .cm, .lm, .cam, .rst, .lst],
        .fourThreeThree: [.gk, .rb, .rcb, .lcb, .lb, .rcm, .cm, .lcm, .rw, .st, .lw],
        .fourFourOneOne: [.gk, .rb, .rcb, .lcb, .lb, .rm, .rcm, .lcm, .lm, .cf, .st],
        .fourFourTwo: [.gk, .rb, .rcb, .lcb, .lb, .rm, .rcm, .lcm, .lm, .rst, .lst],
        .fourFiveOne: [.gk, .rb, .rcb, .lcb, .lb, .rm, .rcm, .cdm, .lcm, .lm, .st],
        .fiveTwoOneTwo: [.gk, .rwb, .rcb, .cb, .lcb, .lwb, .rcm, .lcm, .cam, .rst, .lst],
        .fiveTwoTwoOne: [.gk, .rwb, .rcb, .cb, .lcb, .lwb, .rcm, .lcm, .rf, .lf, .st],
        .fiveTwoThree: [.gk, .rwb, .rcb, .cb, .lcb, .lwb, .rcm, .lcm, .rw, .st, .lw],
        .fiveThreeTwo: [.gk, .rwb, .rcb, .cb, .lcb, .lwb, .rcm, .cm, .lcm, .rst, .lst],
        .fiveFourOne: [.gk, .rwb, .rcb, .cb, .lcb, .lwb, .rm, .rcm, .lcm, .lm, .st],
    ]
}
