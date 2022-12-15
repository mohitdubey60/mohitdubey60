//
//  FadeOutTableViewController.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/12/22.
//

import UIKit
import SwiftUI

class FadeOutTableViewController: UITableViewController {

    let rowIdentifier = "tableRow"
    var viewModel: MockCommentListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: rowIdentifier)
        
        viewModel = MockCommentListViewModel(delegate: self)
        viewModel?.getComments()
    }
}

extension FadeOutTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comments.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier) {
            cell.textLabel?.text = viewModel?.comments[indexPath.row].name
            return cell
        }
        
        return UITableViewCell()
    }
}

extension FadeOutTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPaths = tableView.indexPathsForVisibleRows {
            for indexPath in indexPaths {
                let cellFrame = tableView.rectForRow(at: indexPath)
                print("Cell \(indexPath.row) frame is \(cellFrame.maxY) tableViewFrame is \(tableView.bounds.minY) Sub \(cellFrame.maxY - tableView.bounds.minY) value \((round(cellFrame.maxY - (tableView.bounds.minY + 44)) / 8.8) * 0.1)")
                let cell = tableView.cellForRow(at: indexPath)
                let value = round((cellFrame.maxY - (self.tableView.bounds.minY + 44)) / 8.8) * 0.1
//                UIView.animate(withDuration: 0.1) {
                    cell?.alpha = value
//                }
                
            }
        }
    }
}

extension FadeOutTableViewController: CommentsProtocol {
    func dataReceived() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


struct CommentsTableView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FadeOutTableViewController {
        return FadeOutTableViewController()
    }
    
    func updateUIViewController(_ uiViewController: FadeOutTableViewController, context: Context) {
    }
    
    typealias UIViewControllerType = FadeOutTableViewController
}
