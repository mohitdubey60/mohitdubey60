//
//  SwiftUIKitViewController.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 16/11/22.
//

import UIKit
import SwiftUI

class SwiftUIKitViewController: UIViewController {

    let swiftUIView: UIView = UIView()
    let addViewButton: UIButton = UIButton()
    let removeViewButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        addViewButton.translatesAutoresizingMaskIntoConstraints = false
        removeViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(swiftUIView)
        view.addSubview(addViewButton)
        view.addSubview(removeViewButton)
        
        
        
        
        NSLayoutConstraint.activate([
            swiftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftUIView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIView.widthAnchor.constraint(equalTo: view.widthAnchor),
            swiftUIView.heightAnchor.constraint(equalToConstant: 400),
            addViewButton.widthAnchor.constraint(equalToConstant: 200),
            addViewButton.heightAnchor.constraint(equalToConstant: 70),
            removeViewButton.widthAnchor.constraint(equalToConstant: 200),
            removeViewButton.heightAnchor.constraint(equalToConstant: 70),
            addViewButton.topAnchor.constraint(equalTo: swiftUIView.bottomAnchor, constant: 20),
            removeViewButton.topAnchor.constraint(equalTo: addViewButton.bottomAnchor, constant: 20),
            addViewButton.centerXAnchor.constraint(equalTo: swiftUIView.centerXAnchor),
            removeViewButton.centerXAnchor.constraint(equalTo: swiftUIView.centerXAnchor)
            
        ])
        
        swiftUIView.backgroundColor = .systemBlue
        addViewButton.backgroundColor = .systemBlue
        removeViewButton.backgroundColor = .systemBlue
        addViewButton.setTitle("Add View", for: .normal)
        removeViewButton.setTitle("Remove View", for: .normal)
        swiftUIView.layer.cornerRadius = 20
        addViewButton.layer.cornerRadius = 20
        removeViewButton.layer.cornerRadius = 20
        
        addViewButton.addTarget(self, action: #selector(addController), for: .touchUpInside)
        removeViewButton.addTarget(self, action: #selector(removeController), for: .touchUpInside)

    }
    
    @objc func addController(sender: AnyObject) {
        if swiftUIView.subviews.count == 0 {
            //UIHostingController is used to add swiftuiview view to uiviewController
            let swiftUIViewController = UIHostingController(rootView: SwiftUIControlsView(viewModel: SwiftUIControlsViewModel(urlString: "https://www.online-image-editor.com/styles/2019/images/power_girl.png")))
            self.addChild(swiftUIViewController)
            swiftUIViewController.view.frame = self.swiftUIView.frame
            self.swiftUIView.addSubview(swiftUIViewController.view)
            swiftUIViewController.didMove(toParent: self)
            
            NSLayoutConstraint.activate([
                swiftUIViewController.view.centerXAnchor.constraint(equalTo: self.swiftUIView.centerXAnchor),
                swiftUIViewController.view.centerYAnchor.constraint(equalTo: self.swiftUIView.centerYAnchor),
                swiftUIViewController.view.heightAnchor.constraint(equalTo: self.swiftUIView.heightAnchor),
                swiftUIViewController.view.widthAnchor.constraint(equalTo: self.swiftUIView.widthAnchor)
            ])
        }
    }
    
    @objc func removeController(sender: AnyObject) {
        let subviews = swiftUIView.subviews
        
        subviews.forEach { sView in
            sView.removeFromSuperview()
        }
        
        for ch in children.filter({ cont in
            cont is UIHostingController<SwiftUIControlsView>
        }) {
            ch.removeFromParent()
        }
    }
}

//This class is used to add a uiKit to SwiftUI view
struct SwiftUIKitControlToSwiftUI: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SwiftUIKitViewController {
        return SwiftUIKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: SwiftUIKitViewController, context: Context) {
        //Code for updates here
    }
    
    typealias UIViewControllerType = SwiftUIKitViewController
}
