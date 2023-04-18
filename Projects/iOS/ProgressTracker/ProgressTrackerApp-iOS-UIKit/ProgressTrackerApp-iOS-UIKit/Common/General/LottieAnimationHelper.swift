    //
    //  LottieAnimationHelper.swift
    //  ProgressTrackerApp-iOS-UIKit
    //
    //  Created by mohit.dubey on 17/02/23.
    //

import Foundation
import Lottie

class LottieAnimationHelper {
    class func getLottieObject(for name: String, inView: UIView, loopMode: LottieLoopMode = .loop, animationSpeed: CGFloat = 1) -> LottieAnimationView {
        let animationView: LottieAnimationView = .init(name: name)
        animationView.frame = inView.bounds
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        inView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: inView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: inView.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: inView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: inView.bottomAnchor)
        ])
        
        return animationView
    }
}
