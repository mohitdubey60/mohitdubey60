//
//  BaseViewController.swift
//  ApplicationLifeCycleUIKIt
//
//  Created by mohit.dubey on 13/05/23.
//

import UIKit

class BaseUIViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        print("=================================================")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) InitWithNibname: called for UIVIEWCONTROLLER")
    }
    
    required init?(coder: NSCoder) {
        print("=================================================")
        super.init(coder: coder)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) InitWithCoder: called for UIVIEWCONTROLLER")
    }
    
    override func awakeFromNib() {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) awakeFromNib called for UIVIEWCONTROLLER")
        super.awakeFromNib()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) willMoveToParentViewController: called for UIVIEWCONTROLLER")
    }
    
    override var prefersStatusBarHidden: Bool {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) prefersStatusBarHidden called for UIVIEWCONTROLLER")
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) preferredStatusBarUpdateAnimation called for UIVIEWCONTROLLER")
        return .fade
    }
    
    override func loadView() {
        super.loadView()
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) loadView called for UIVIEWCONTROLLER")
    }
    
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) loadViewIfNeeded called for UIVIEWCONTROLLER")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) prepareForSegue: called for UIVIEWCONTROLLER")
    }
    
    override func viewDidLoad() {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewDidLoad called for UIVIEWCONTROLLER")
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
//    override var extendedLayoutIncludesOpaqueBars: Bool
    
//    override var edgesForExtendedLayout: UIRectEdge
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) updateViewConstraints called for UIVIEWCONTROLLER")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewWillLayoutSubviews called for UIVIEWCONTROLLER")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewDidLayoutSubviews called for UIVIEWCONTROLLER")
    }
    
    //Animation: The animation that transitions from Scene A to Scene B runs. Step 18 does not happen until the animation finishes.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewDidAppear called for UIVIEWCONTROLLER")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) didMoveToParentViewController: called for UIVIEWCONTROLLER")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewWillDisappear: called for UIVIEWCONTROLLER")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewDidDisappear: called for UIVIEWCONTROLLER")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) viewWillTransition: called for UIVIEWCONTROLLER")
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) willTransition: called for UIVIEWCONTROLLER")
    }
    
    @objc func rotate() {
        print("=================================================")
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) rotate: called for UIVIEWCONTROLLER")
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("ViewController did receive memory warning")
    }
    
    deinit {
        print("Mohit: \(String(describing: type(of: self))) \(String(format: "%p", self)) Deinit called for UIVIEWController")
    }
}
