//
//  AsyncListViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 07/07/23.
//

import UIKit

class AsyncListViewController: UIViewController {

    var tableView: UITableView?
    private let viewModel: AsyncListControllerViewModel
    
    init(viewModel: AsyncListControllerViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = AsyncListControllerViewModel(service: AsyncAwaitWebService())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView!)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.expandToTakeCompleteArea(self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        loadListData()
        loadListDataAsync()
        
        // Do any additional setup after loading the view.
    }
    
    func loadListData() {
        do {
            try viewModel.getList()
        } catch let err {
            print("Error -> \(err)")
        }
    }
    
    func loadListDataAsync() {
        let task = Task {
            do {
                let products = try await viewModel.getList()
                print("Products -> \(products.products?.count ?? 0)")
            } catch let err {
                print("Error -> \(err)")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
