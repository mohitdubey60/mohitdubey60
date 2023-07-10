//
//  BaseUIVIew.swift
//  ApplicationLifeCycleUIKIt
//
//  Created by mohit.dubey on 13/05/23.
//

import UIKit

class BaseUIVIew: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("===============================================================")
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) initWithCoder called for UIVIEW")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("===============================================================")
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) initWithFrame called for UIVIEW")
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) setNeedsDisplay called for UIVIEW")
    }
    
    override func addConstraints(_ constraints: [NSLayoutConstraint]) {
        super.addConstraints(constraints)
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) addConstraints[] called for UIVIEW")
    }
    
    override func addConstraint(_ constraint: NSLayoutConstraint) {
        super.addConstraint(constraint)
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) addConstraint called for UIVIEW")
    }

    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) willMoveToSuperview: called for UIVIEW")
    }
    
    override func invalidateIntrinsicContentSize() {
        super.invalidateIntrinsicContentSize()
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) invalidateIntrinsicContentSize called for UIVIEW")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) awakeFromNib called for UIVIEW")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) willMoveToWindow: called for UIVIEW")
    }
    
    override func needsUpdateConstraints() -> Bool {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) needsUpdateConstraints called for UIVIEW")
        
        return super.needsUpdateConstraints()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) didMoveToWindow called for UIVIEW")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) setNeedsLayout called for UIVIEW")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) updateConstraints called for UIVIEW")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) layoutSubviews called for UIVIEW")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) drawRect called for UIVIEW")
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) drawLayer called for UIVIEW")
    }
    
    override func drawHierarchy(in rect: CGRect, afterScreenUpdates afterUpdates: Bool) -> Bool {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) drawHierarchy called for UIVIEW")
        
        return super.drawHierarchy(in: rect, afterScreenUpdates: afterUpdates)
    }
    
    override func convert(_ point: CGPoint, to coordinateSpace: UICoordinateSpace) -> CGPoint {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) convertPoint called for UIVIEW")
        
        return super.convert(point, to: coordinateSpace)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) hitTest called for UIVIEW")
        
        return super.hitTest(point, with: event)
    }
    
    deinit {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) Deinit called for UIVIEW")
    }
}
