//
//  CircularProgressView.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 23/02/23.
//

import UIKit

class CircularProgressView: UIView {
    @IBOutlet weak var progressLabel: UILabel!
    private var progressLayer = CAShapeLayer()
    private var tracklayer = CAShapeLayer()
    
    var progressColor:UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor:UIColor = UIColor.white {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        createCircularPath()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupPath() {
        createCircularPath()
    }
    
    private func createCircularPath() {
        self.backgroundColor = UIColor.clear
        let heightWidth = (self.bounds.width <= self.bounds.height ? self.bounds.width : self.bounds.height)
        self.layer.cornerRadius = heightWidth / 2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0),
                                      radius: (heightWidth - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor.cgColor
        tracklayer.lineWidth = 10.0;
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0;
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
            // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateCircle")
    }
}
