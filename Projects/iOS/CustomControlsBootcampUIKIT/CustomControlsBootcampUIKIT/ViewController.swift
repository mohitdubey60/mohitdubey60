    //
    //  ViewController.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 09/05/23.
    //

import UIKit
import WebKit
import Combine

fileprivate class ListTableViewCell: UITableViewCell {
    
}

fileprivate struct Controls {
    let controlName: String
    let controller: UIViewController?
}

class ViewController: UIViewController {
    private var controls: [Controls] = {
        return [Controls(controlName: "ExperimentControl", controller: nil),
                Controls(controlName: "CompositionalCollectionViewLayout", controller: nil),
                Controls(controlName: "VideoListTableViewController", controller: nil),
                Controls(controlName: "CustomControllersViewController", controller: nil),
                Controls(controlName: "FlickerParentViewController", controller: nil),
                Controls(controlName: "CustomWebViewController", controller: nil),
                Controls(controlName: "PresentNavigationParentViewController", controller: nil),
                Controls(controlName: "AsyncListViewController", controller: nil),
                Controls(controlName: "DynamicMemberLookup", controller: nil),
                Controls(controlName: "DeviceMotionViewController", controller: nil),
                Controls(controlName: "CombineViewController", controller: nil),
                Controls(controlName: "PhotosAndPDFConverterViewController", controller: nil)]
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleTableRowClick(indexPath)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") {
            let control = controls[indexPath.row]
            cell.textLabel?.text = control.controlName
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ViewController {
    func handleTableRowClick(_ indexPath: IndexPath) {
        if controls[indexPath.row].controlName == "ExperimentControl", let controller = UIStoryboard(name: "ExperimentFlow", bundle: nil).instantiateViewController(withIdentifier: "NavigationExperimentFlowViewController") as? NavigationExperimentFlowViewController {
            controller.updateViewModel(NavigationExperimentFlowViewModel(manager: OnboardingExperimentFlowManager(flow: [.language, .profile, .interest]), delegate: controller))
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "CompositionalCollectionViewLayout", let controller = UIStoryboard(name: "Controls", bundle: nil).instantiateViewController(withIdentifier: "CompositionalCollectionViewController") as? CompositionalCollectionViewController {
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "VideoListTableViewController", let controller = UIStoryboard(name: "Controls", bundle: nil).instantiateViewController(withIdentifier: "VideoListTableViewController") as? VideoListTableViewController {
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "CustomControllersViewController", let controller = UIStoryboard(name: "Controls", bundle: nil).instantiateViewController(withIdentifier: "CustomControllersViewController") as? CustomControllersViewController {
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "FlickerParentViewController", let controller = UIStoryboard(name: "Controls", bundle: nil).instantiateViewController(withIdentifier: "FlickerParentViewController") as? FlickerParentViewController {
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "CustomWebViewController" {
            let controller = CustomWebViewController(configuration: CustomWebViewConfiguration(context: "customActionObject").getConfiguration())
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "PresentNavigationParentViewController" {
            let controller = PresentNavigationParentViewController()
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "AsyncListViewController" {
            let controller = AsyncListViewController(viewModel: AsyncListControllerViewModel(service: AsyncAwaitWebService()))
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "DynamicMemberLookup" {
            BeautifiedJsonParser().parseFakeProducts()
            BeautifiedJsonParser().parseFakeWallet()
        } else if controls[indexPath.row].controlName == "DeviceMotionViewController" {
            let controller = DeviceMotionViewController()
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "CombineViewController" {
            let controller = CombineViewController()
            navigationController?.pushViewController(controller, animated: true)
        } else if controls[indexPath.row].controlName == "PhotosAndPDFConverterViewController" {
            let controller = PhotosAndPDFConverterViewController()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
