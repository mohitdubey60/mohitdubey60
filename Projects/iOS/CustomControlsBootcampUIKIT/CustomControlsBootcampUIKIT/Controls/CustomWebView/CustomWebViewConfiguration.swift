//
//  CustomWebViewConfiguration.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 21/06/23.
//

import Foundation
import WebKit

class CustomWebViewConfiguration {
    private let configuration: WKWebViewConfiguration
    private let context: String
    
    init(context: String) {
        self.context = context
        configuration = WKWebViewConfiguration()
        setupDefaultConfiguration()
    }
    
    private func setupDefaultConfiguration() {
        configuration.allowsInlineMediaPlayback = false
        configuration.allowsInlineMediaPlayback = false
        configuration.allowsAirPlayForMediaPlayback = false
        configuration.ignoresViewportScaleLimits = false
        configuration.dataDetectorTypes = [.all]
        
        let controller = WKUserContentController()
        getDefaultUserScript(with: context).forEach({ controller.addUserScript($0) })
        
        configuration.userContentController = controller
    }
    
    private func getDefaultUserScript(with actionObject: String) -> [WKUserScript] {
        var userScripts: [WKUserScript] = []
        let actions = JSFunction.returnJS(with: actionObject)
        userScripts.append(WKUserScript(source: actions, injectionTime: .atDocumentStart, forMainFrameOnly: false))
        
        return userScripts
    }
    
    func getConfiguration() -> WKWebViewConfiguration {
        return configuration
    }
}
