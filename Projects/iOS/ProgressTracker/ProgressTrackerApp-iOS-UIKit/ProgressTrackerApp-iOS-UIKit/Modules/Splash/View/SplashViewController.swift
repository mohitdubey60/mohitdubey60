    //
    //  ViewController.swift
    //  ProgressTrackerApp-iOS-UIKit
    //
    //  Created by mohit.dubey on 09/02/23.
    //

import UIKit
import Lottie

class SplashViewController: BaseViewController {
    weak var coordinatorDelegate: SplashCoordinatorProtocol?
    var animationView: LottieAnimationView?
    var timer: Timer!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        
        animationView = LottieAnimationHelper.getLottieObject(for: "progress-human", inView: view)
        animationView?.play()
        
        setupTimer()
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(onTimerTick), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerTick() {
        if count > 10 && timer != nil {
            timer.invalidate()
            timer = nil
            
            coordinatorDelegate?.navigateToNextAndDestroyCurrent()
        }
        
        if let speed = animationView?.animationSpeed {
            animationView?.animationSpeed = speed + 1
        }
        
        count += 1
    }
}

