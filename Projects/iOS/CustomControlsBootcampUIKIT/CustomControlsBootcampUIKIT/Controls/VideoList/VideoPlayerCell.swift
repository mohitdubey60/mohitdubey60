//
//  VideoPlayerCell.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/05/23.
//

import UIKit
import AVFoundation

protocol IVideoPlayerCell: UITableViewCell {
    var playabilityDelegate: VideoPlayability? { get set }
    
    var isPlaying: Bool { get set }
    var videoPlayerView: UIView { get }
    var videoPlayer: AVPlayer? { get }
    func playVideo()
    func pauseVideo()
    func willDisplay()
    func didEndDisplay()
    func cleanUp()
}

extension IVideoPlayerCell {
    func willDisplay() {
        
    }
    func didEndDisplay() {
        pauseVideo()
        videoPlayer?.seek(to: .zero)
        cleanUp()
    }
    func playVideo() {
        if !isPlaying {
            videoPlayer?.play()
            print("Mohit: Play called -> \(videoPlayer)")
            if videoPlayer != nil {
                isPlaying = true
            }
        }
    }
    func pauseVideo() {
        print("Mohit: Pause called -> \(videoPlayer)")
        videoPlayer?.pause()
        isPlaying = false
    }
}
