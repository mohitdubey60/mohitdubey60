//
//  SecondViewController.swift
//  ApplicationLifeCycleUIKIt
//
//  Created by mohit.dubey on 13/05/23.
//

import UIKit

class SecondViewController: BaseUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveToThirdViewController(_ sender: Any) {
        print("=================CTA==================")
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsActionViewController") as? NotificationsActionViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
