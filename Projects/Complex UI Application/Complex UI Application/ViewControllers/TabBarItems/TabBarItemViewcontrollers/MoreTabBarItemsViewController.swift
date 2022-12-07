//
//  MoreTabBarItemsViewController.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 08/08/22.
//

import UIKit

class MoreTabBarItemsViewController: UIViewController {

    @IBOutlet weak var menuBottomBarItems: UITableView!
    let allCases = Array(HomeTabBarItems.allCases.filter ({ item in
        item != .more
    }).suffix(from: 4))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ImageLabelTableViewCell", bundle: nil)
        menuBottomBarItems.register(nib, forCellReuseIdentifier: "ImageLabelTableViewCell")
        menuBottomBarItems.delegate = self
        menuBottomBarItems.dataSource = self
    }
}

extension MoreTabBarItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? ImageLabelTableViewCell,
           let name = cell.title.text,
            let caseName = HomeTabBarItems(rawValue: name),
            let controller = caseName.viewController {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MoreTabBarItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageLabelTableViewCell") as? ImageLabelTableViewCell {
            cell.imageItem.image = allCases[indexPath.row].iconSelected
            cell.title.text = allCases[indexPath.row].rawValue
            cell.controller = allCases[indexPath.row].rawValue
            return cell
        }
        
        return UITableViewCell()
    }
}
