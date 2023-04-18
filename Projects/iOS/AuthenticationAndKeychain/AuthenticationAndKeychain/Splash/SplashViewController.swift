//
//  ViewController.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 18/03/23.
//

import UIKit
import Lottie

protocol SplashViewControllerProtocol: AnyObject {
    func rickAndMortyProcessingComplete()
}

class SplashViewController: BaseViewController {
    var animationView: LottieAnimationView!
    var presenter: SplashPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animationView = LottieAnimationHelper.getLottieObject(for: LottieAnimations.splashAnimation.rawValue, inView: view)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func rickAndMortyProcessingComplete() {
        animationView.stop()
    }
}

