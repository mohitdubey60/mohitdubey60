//
//  BaseUITableViewController.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 24/03/23.
//

import UIKit

class BaseUITableViewController: UITableViewController {
    
}

extension BaseUITableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        super.scrollViewDidEndDecelerating(scrollView)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        super.scrollViewWillBeginDecelerating(scrollView)
    }
}
