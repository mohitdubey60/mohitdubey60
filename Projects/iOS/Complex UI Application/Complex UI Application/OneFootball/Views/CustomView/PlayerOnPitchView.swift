//
//  PlayerOnPitchView.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 27/09/22.
//

import UIKit

class PlayerOnPitchView: UIView {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var SubstitureIconImageView: UIImageView!
    @IBOutlet weak var GoalsIconImageView: UIImageView!
    @IBOutlet weak var substituteLabel: UILabel!
    @IBOutlet weak var playerCardView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    
    @IBOutlet weak var substitutionTimeLabel: UILabel!
    
    
    var playerVM: PlayerOnPitchViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func popuplateView() {
        playerName.text = playerVM?.player.nickName
        playerNumber.text = "\(playerVM?.player.number ?? -1)"
        if let urlPath = playerVM?.player.thumbnailSrc, let url = URL(string: urlPath) {
            playerImageView.downloaded(from: url, contentMode: .scaleAspectFill)
            playerImageView.clipsToBounds = true
            playerImageView.cornerRadius = 16
            if let rating = playerVM?.player.rating {
                ratingView.alpha = 1
                ratingLabel.text = rating.value ?? ""
                if let grade = rating.grade {
                    switch grade {
                        case .average:
                            ratingView.backgroundColor = .orange
                        case .high:
                            ratingView.backgroundColor = .systemGreen
                        case .low:
                            ratingView.backgroundColor = .red
                    }
                }
            } else {
                ratingView.alpha = 0
            }
        }
    }
}
