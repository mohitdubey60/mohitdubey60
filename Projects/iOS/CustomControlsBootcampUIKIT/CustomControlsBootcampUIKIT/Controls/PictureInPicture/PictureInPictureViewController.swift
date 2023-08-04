    //
    //  PictureInPictureViewController.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 02/08/23.
    //

import UIKit
import AVKit

class PictureInPictureViewController: UIViewController {
    @IBOutlet weak var AVPlayerParentView: UIView!
    var avPlayer: AVPlayer!
    var playerController: AVPlayerViewController!
    
    static func enableBackgroundMode() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            //        avPlayer = AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4")!)
            //        let playerLayer = AVPlayerLayer(player: avPlayer)
            //        playerLayer.frame = self.view.bounds
            //        self.view.layer.addSublayer(playerLayer)
        
        let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4")!
        avPlayer = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.view.frame = AVPlayerParentView.bounds
        playerViewController.player = avPlayer
        
        playerController = AVPlayerViewController()
        playerController.delegate = self
        playerViewController.allowsPictureInPicturePlayback = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didfinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer.currentItem)
            //        playerController.player = avPlayer
            //        playerController.allowsPictureInPicturePlayback = true
            //        playerController.delegate = self
        
        self.addChild(playerViewController)
        self.view.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
        
        avPlayer.play()
            //        self.present(playerController, animated: true, completion : nil)
        
            // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func playButtonAction(_ sender: Any) {
    }
    
    @IBAction func exportButtonAction(_ sender: Any) {
    }
}

extension PictureInPictureViewController: AVPlayerViewControllerDelegate {
    @objc func didfinishPlaying(note : NSNotification)  {
        playerController.dismiss(animated: true, completion: nil)
        let alertView = UIAlertController(title: "Finished", message: "Video finished", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController,
                              restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        
    }
}
