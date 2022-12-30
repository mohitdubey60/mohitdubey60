//
//  MatchDayFactory.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 25/09/22.
//

import Foundation

class MatchDayFactory {
    class func makeMatchDayService() -> MatchDayService {
        return OneFootballConstants.isLocal ? MockMatchDayService() : MockMatchDayService()
    }
}
