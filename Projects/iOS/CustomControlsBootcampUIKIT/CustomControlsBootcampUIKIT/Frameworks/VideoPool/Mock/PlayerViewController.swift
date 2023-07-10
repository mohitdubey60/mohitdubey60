//
//  PlayerViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 10/05/23.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func prepareVideoAction(_ sender: Any) {
        //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
        let urlString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        VideoPoolManager.shared.preparePlayer(url: urlString, subscriber: self)
        
    }
}

extension PlayerViewController: VideoPlayerStatus {
    func playerReady(url: URL, player: AVPlayer) {
        print("Player ready for \(url.absoluteString)")
    }
}
