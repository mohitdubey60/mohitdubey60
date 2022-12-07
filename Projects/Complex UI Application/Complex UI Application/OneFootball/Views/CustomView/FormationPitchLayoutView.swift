//
//  self.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 25/09/22.
//

import UIKit

class FormationPitchLayoutView: UIView {

    var lineupViewModel: LineupViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func animateSubstituteSubviews() {
        for subView in subviews {
            if subView.subviews.count > 1 {
                for innerSubView in subView.subviews {
                    UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse]) {
                        if innerSubView.alpha == 0 {
                            innerSubView.alpha = 1
                        } else if innerSubView.alpha == 1 {
                            innerSubView.alpha = 0
                        }
                    }
                }
            }
        }
    }
    
    func cleanupUI() {
        for v in subviews {
            v.removeFromSuperview()
        }
    }
    
    func defineFormation(side: TeamSide) {
        var totalIncrement = 1
        var verticalDrop = 0
        
        
        let formationDiv = PlayerHelper.getFormationDivision(formation: lineupViewModel?.team.formationLayout ?? 0)
        let players = lineupViewModel?.players.sorted(by: { $0.positionTactical ?? 0 > $1.positionTactical ?? 0 }) ?? []
        var index: Int = 0
        for item in formationDiv.reversed() {
            for internalIndex in 0 ..< item {
                let v = UIView()
                self.addSubview(v)
                let heightOfEachView = self.bounds.height / CGFloat(formationDiv.count)
                let widthOfEachView = self.bounds.width / CGFloat(item)
                v.frame = CGRect(x: CGFloat(internalIndex) * widthOfEachView, y: CGFloat(verticalDrop) * heightOfEachView, width: widthOfEachView, height: heightOfEachView)
                v.tag = players[index].positionTactical!
                totalIncrement += 1
                
                if let playerView: PlayerOnPitchView = .fromNib() {
                    let substitude = lineupViewModel?.groupedSubstitution[players[index].id!]?.first ?? nil
                    
                    playerView.playerVM = PlayerOnPitchViewModel(player: players[index], goals: lineupViewModel?.groupedGoalsByPlayers[players[index].id!] ?? [], substitute: substitude, cards: lineupViewModel?.groupedCardsByPlayer[players[index].id!] ?? [])
                    
                    if substitude != nil {
                        playerView.substituteLabel.alpha = 1
                        playerView.substituteLabel.text = "Out"
                        playerView.substituteLabel.textColor = .red
                        playerView.SubstitureIconImageView.tintColor = .red
                        playerView.SubstitureIconImageView.isHidden = false
                        playerView.substitutionTimeLabel.text = substitude?.minuteDisplay ?? ""
                        playerView.substitutionTimeLabel.alpha = 1
                        
                        if let playerViewSubs: PlayerOnPitchView = .fromNib(), let pl = substitude?.playerIn {
                            playerViewSubs.translatesAutoresizingMaskIntoConstraints = false
                            playerViewSubs.playerVM = PlayerOnPitchViewModel(player: pl, goals: lineupViewModel?.groupedGoalsByPlayers[pl.id!] ?? [], substitute: nil, cards: lineupViewModel?.groupedCardsByPlayer[pl.id!] ?? [])
                            playerViewSubs.substituteLabel.alpha = 1
                            playerViewSubs.substituteLabel.text = "In"
                            playerViewSubs.substituteLabel.textColor = .systemGreen
                            playerViewSubs.SubstitureIconImageView.tintColor = .systemGreen
                            playerViewSubs.SubstitureIconImageView.isHidden = false
                            playerViewSubs.substitutionTimeLabel.text = substitude?.minuteDisplay ?? ""
                            playerViewSubs.substitutionTimeLabel.alpha = 1
                            
                            v.addSubview(playerViewSubs)
                            NSLayoutConstraint.activate([playerViewSubs.heightAnchor.constraint(equalToConstant: 90),
                                                         playerViewSubs.widthAnchor.constraint(equalToConstant: 60),
                                                         playerViewSubs.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -5),
                                                         playerViewSubs.centerXAnchor.constraint(equalTo: v.centerXAnchor)])
                            
                            if let goals = lineupViewModel?.groupedGoalsByPlayers[pl.id!], goals.count > 0 {
                                playerViewSubs.GoalsIconImageView.isHidden = false
                            }
                            v.layoutIfNeeded()
                            let tag = Int(pl.id!) ?? 0
                            playerViewSubs.tag = tag
                            playerViewSubs.popuplateView()
                            playerViewSubs.alpha = 0
                            
                        }
                    }
                    
                    if let goals = lineupViewModel?.groupedGoalsByPlayers[players[index].id!], goals.count > 0 {
                        playerView.GoalsIconImageView.isHidden = false
                    }
                    
                    v.addSubview(playerView)
                    playerView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([playerView.heightAnchor.constraint(equalToConstant: 90),
                                                 playerView.widthAnchor.constraint(equalToConstant: 60),
                                                 playerView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -5),
                                                 playerView.centerXAnchor.constraint(equalTo: v.centerXAnchor)])
                    v.layoutIfNeeded()
                    let tag = Int(players[index].id!) ?? 0
                    playerView.tag = tag
                    playerView.popuplateView()
                }
                
                index += 1
            }
            verticalDrop += 1
        }
    }
}
