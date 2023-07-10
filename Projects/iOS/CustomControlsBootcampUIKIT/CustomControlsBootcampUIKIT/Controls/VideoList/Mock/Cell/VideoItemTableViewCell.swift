    //
    //  VideoItemTableViewCell.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 10/05/23.
    //

import UIKit
import AVFoundation

class VideoItemTableViewCell: UITableViewCell {
    weak var playabilityDelegate: VideoPlayability?
    
    private(set) var videoPlayer: AVPlayer?
    var videoPlayerView: UIView {
        placeholderView
    }
    var isPlaying: Bool = false
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var model: VideoItemModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
            // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeholderView.layer.sublayers?.removeAll(where: { $0 is AVPlayerLayer })
        videoPlayer = nil
        imageView?.image = nil
        thumbnailImageView.isHidden = false
    }
    
    private func setupImage() async {
        do {
            let imageUrl = model.baseMediaUrl + model.thumb
            if let data = try await ImageCacheManager.shared.getImage(url: imageUrl) {
                DispatchQueue.main.async {[weak self] in
                    autoreleasepool {
                        self?.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        } catch {
            print("Cannot download image \(error.localizedDescription)")
        }
        
    }
    
    func displayCell(model data: VideoItemModel) {
        model = data
        
        cellTitle.text = model.title
        cellDescription.text = model.description
        
        Task.init {
            await setupImage()
        }
        
        if let url = model.sources.first {
            print("Requested for player \(url)")
            VideoPoolManager.shared.preparePlayer(url: url, subscriber: self)
        }
    }
}

extension VideoItemTableViewCell: VideoPlayerStatus {
    
    func playerReady(url: URL, player: AVPlayer) {
        DispatchQueue.main.async {[weak self] in
            autoreleasepool {
                self?.thumbnailImageView.isHidden = true
                self?.videoPlayer = player
                print("Mohit: Received Response for player \(player) \(url.absoluteString)")
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self?.placeholderView.bounds ?? .zero
                self?.placeholderView.layer.addSublayer(playerLayer)
                self?.pauseVideo()
                
                self?.playabilityDelegate?.playCellInCenter()
            }
        }
        
    }
}

extension VideoItemTableViewCell: IVideoPlayerCell {
    func cleanUp() {
        placeholderView.layer.sublayers?.removeAll(where: { $0 is AVPlayerLayer })
        videoPlayer = nil
        imageView?.image = nil
        thumbnailImageView.isHidden = false
    }
}
