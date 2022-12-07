    //
    //  LineupViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 25/09/22.
    //

import UIKit

class LineupViewController: UIViewController {
    
    @IBOutlet weak var teamSelectSegmentedControl: UISegmentedControl!
    var matchDayViewModel: MatchDayViewModel?
    var formationPitchLayoutView: FormationPitchLayoutView!
    var formationCategory: [PlayerPosition] = [.goalkeeper, .defender, .midfielder, .forward]
    var colorArray: [UIColor] = [.red, .yellow, .blue, .systemPink, .black, .brown, .cyan, .magenta]
    var teamSide: TeamSide = .home
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        formationPitchLayoutView?.animateSubstituteSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func cleanUI() {
        formationPitchLayoutView.cleanupUI()
    }
    
    private func lineupFormation(for: TeamSide) {
        matchDayViewModel?.getFormationDetails(side: teamSide, completion: {[weak self] in
            guard let `self` = self else {
                return
            }
            
            if let lineupViewModel: LineupViewModel = self.matchDayViewModel?.lineupViewModel {
                self.formationPitchLayoutView.lineupViewModel = lineupViewModel
                self.formationPitchLayoutView.defineFormation(side: self.teamSide)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                    self?.formationPitchLayoutView.animateSubstituteSubviews()
                }
            }
        })
    }
    
    func updateFormation(team: TeamSide) {
        teamSide = team
        cleanUI()
        lineupFormation(for: teamSide)
    }
    
    @objc func changeSegmentedControlValue(sender: UISegmentedControl) {
        updateFormation(team: teamSelectSegmentedControl.selectedSegmentIndex == 1 ? .away : .home)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamSelectSegmentedControl.addTarget(self, action: #selector(changeSegmentedControlValue), for: .valueChanged)
        matchDayViewModel = MatchDayViewModel(service: MatchDayFactory.makeMatchDayService())
        
        if let fplv: FormationPitchLayoutView = .fromNib() {
            DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
                guard let `self` = self else {
                    return
                }
                self.formationPitchLayoutView = fplv
                self.formationPitchLayoutView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.formationPitchLayoutView)
                var width = self.view.bounds.width * 0.8
                var height = width * (14/9)
                if height >= (self.view.bounds.height - (self.tabBarController?.tabBar.frame.size.height ?? 0)) {
                    height = self.view.bounds.height
                    width = height * (9/14)
                }
                
                NSLayoutConstraint.activate([
                    self.formationPitchLayoutView.widthAnchor.constraint(equalToConstant: width),
                    self.formationPitchLayoutView.heightAnchor.constraint(equalToConstant: height),
                    self.formationPitchLayoutView.topAnchor.constraint(equalTo: self.teamSelectSegmentedControl.bottomAnchor, constant: 12),
                    self.formationPitchLayoutView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
                self.view.layoutIfNeeded()
                
                self.matchDayViewModel?.getMatchDayData {[weak self] in
                    guard let `self` = self else {
                        return
                    }
                    
                    self.teamSelectSegmentedControl.setTitle(self.matchDayViewModel?.matchDayModel?.match?.teamhome?.name ?? "", forSegmentAt: 0)
                    self.teamSelectSegmentedControl.setTitle(self.matchDayViewModel?.matchDayModel?.match?.teamaway?.name ?? "", forSegmentAt: 1)
                    
                    self.lineupFormation(for: self.teamSide)
                }
            }
        }
    }
}
