//
//  GoalsDashboardViewController.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 10/02/23.
//

import UIKit
import Charts

class GoalsDashboardViewController: BaseViewController {
    @IBOutlet var ringProgressView: UIView!
    @IBOutlet weak var chartsContainerView: UIView!
    
    var vm: GoalsDashboardViewModel!
    
    private func setupRingProgress() {
            // Do any additional setup after loading the view.
        
        if let circularProgress = UINib(nibName: CircularProgressView.className, bundle: .main).instantiate(withOwner: nil).first as? CircularProgressView {
            circularProgress.translatesAutoresizingMaskIntoConstraints = false
            ringProgressView.addSubview(circularProgress)
            NSLayoutConstraint.activate([
                circularProgress.centerXAnchor.constraint(equalTo: ringProgressView.centerXAnchor),
                circularProgress.centerYAnchor.constraint(equalTo: ringProgressView.centerYAnchor),
                circularProgress.widthAnchor.constraint(equalToConstant: ringProgressView.bounds.width),
                circularProgress.heightAnchor.constraint(equalToConstant: ringProgressView.bounds.height)
            ])
            
            circularProgress.progressColor = .darkGray
            circularProgress.trackColor = .lightGray
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                circularProgress.setupPath()
                circularProgress.setProgressWithAnimation(duration: 1, value: 0.8)
            }
        }
    }
    
    private func setupBarCharts() {
        if let barChartView = UINib(nibName: BarChartsView.className, bundle: .main).instantiate(withOwner: nil).first as? BarChartsView {
            barChartView.translatesAutoresizingMaskIntoConstraints = false
            chartsContainerView.addSubview(barChartView)
            
            NSLayoutConstraint.activate([
                barChartView.centerXAnchor.constraint(equalTo: chartsContainerView.centerXAnchor),
                barChartView.centerYAnchor.constraint(equalTo: chartsContainerView.centerYAnchor),
                barChartView.widthAnchor.constraint(equalToConstant: chartsContainerView.bounds.width),
                barChartView.heightAnchor.constraint(equalToConstant: chartsContainerView.bounds.height)
            ])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm = GoalsDashboardViewModel()

        navigationController?.setNavigationBarHidden(false, animated: false)
        
        setupRingProgress()
        setupBarCharts()
        
        Date().getDatesOfWeek()
    }
}
