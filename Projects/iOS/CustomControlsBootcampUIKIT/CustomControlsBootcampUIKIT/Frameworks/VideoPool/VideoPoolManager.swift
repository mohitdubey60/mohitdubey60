    //
    //  VideoPoolManager.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 10/05/23.
    //

import Foundation
import AVFoundation

struct VideoPoolConfig {
    let maxAllowedPrepareRequest: UInt16
}

enum PlayerStatus {
    case notStarted
    case requestInProgress
    case ready
}

protocol VideoPlayerStatus: AnyObject {
    func playerReady(url: URL, player: AVPlayer)
}

class PlayerRequest: NSObject {
    static func == (lhs: PlayerRequest, rhs: PlayerRequest) -> Bool {
        lhs.url.absoluteString == rhs.url.absoluteString
    }
    weak var subscriber: VideoPlayerStatus?
    let url: URL
    var player: AVPlayer?
    var status: PlayerStatus
    var observer: NSKeyValueObservation?
    
    init(url: URL, player: AVPlayer? = nil, status: PlayerStatus) {
        self.url = url
        self.player = player
        self.status = status
    }
    
    deinit {
        observer?.invalidate()
        player = nil
    }
}

extension PlayerRequest {
    func preparePlayer() {
        let player = AVPlayer(url: url)
        self.player = player
        observer = player.observe(\.currentItem?.status, options: [.new, .old]) {[weak self] (player, change) in
            print("Mohit: Observer called")
            switch (player.status) {
                case .readyToPlay:
                        // here is where it's ready to play so play player
                    print("Mohit: Player is ready to play")
                    if  let url = player.urlOfCurrentlyPlayingInPlayer() {
                        self?.status = .ready
                        self?.subscriber?.playerReady(url: url, player: player)
                    }
                case .failed, .unknown:
                    print("Mohit: Media Failed to Play")
                @unknown default:
                    break
            }
        }
        self.player?.automaticallyWaitsToMinimizeStalling = true
    }
    
    func sendPlayerIfReady() {
        if let player {
            subscriber?.playerReady(url: url, player: player)
        }
    }
}

class VideoPoolManager {
    static let shared: VideoPoolManager =
    VideoPoolManager(config: VideoPoolConfig(maxAllowedPrepareRequest: 3))
    let config: VideoPoolConfig
    private var playerRequests: BasicLRU<PlayerRequest>
    
    init(config: VideoPoolConfig) {
        self.config = config
        
        playerRequests = BasicLRU(maxSize: Int(config.maxAllowedPrepareRequest))
    }
    
    func preparePlayer(url urlString: String, subscriber playerController: VideoPlayerStatus) {
        if let url = URL(string: urlString) {
            preparePlayer(fromUrl: url, subscriber: playerController)
        }
    }
}

extension VideoPoolManager {
    private func preparePlayer(_ url: URL, _ subscriber: VideoPlayerStatus?) {
        let playerRequest = PlayerRequest(url: url, status: .notStarted)
        if let subscriber = subscriber {
            playerRequest.subscriber = subscriber
        }
        playerRequests.append(playerRequest)
        
        playerRequest.preparePlayer()
    }
    
    private func preparePlayer(fromUrl url: URL, subscriber: VideoPlayerStatus?) {
        if let playerRequest = playerRequests.first(where: { $0.url == url }) {
            playerRequests.append(playerRequest)
            if playerRequest.status == .ready {
                playerRequest.sendPlayerIfReady()
            }
        } else {
            preparePlayer(url, subscriber)
        }
    }
}
