//
//  DeviceMotionViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 14/07/23.
//

import UIKit

class DeviceMotionViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = DeviceMotionSwiftUIView(deviceMotionViewModel: DeviceMotionSwiftUIViewModel())
        // Do any additional setup after loading the view.
        addSwiftUIViewToController(swiftUIView)
    }

}
