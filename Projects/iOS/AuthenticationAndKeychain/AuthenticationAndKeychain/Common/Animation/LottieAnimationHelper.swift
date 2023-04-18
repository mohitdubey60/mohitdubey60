//
//  LottieAnimationHelper.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 21/03/23.
//

import UIKit
import Lottie

enum LottieAnimations: String {
    case splashAnimation = "splashAnimation"
}

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
