//
//  AVPlayerExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 10/05/23.
//

import Foundation
import AVFoundation

extension AVPlayer {
    func urlOfCurrentlyPlayingInPlayer() -> URL? {
        return ((currentItem?.asset) as? AVURLAsset)?.url
    }
}

extension AVPlayerItem {
    func urlOfCurrentlyPlayingInPlayer() -> URL? {
        return (asset as? AVURLAsset)?.url
    }
}
