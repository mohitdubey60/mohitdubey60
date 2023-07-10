//
//  VideoListTableViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 10/05/23.
//

import UIKit

class VideoListTableViewController: VideoPlayerTableViewController {

    var videoList: [VideoItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UINib(nibName: "VideoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoItemTableViewCell")
        
        if let stringPath = Bundle.main.path(forResource: "VideoListMock", ofType: "json") {
            if #available(iOS 16.0, *) {
                let url = URL(filePath: stringPath)
                
                guard url.startAccessingSecurityScopedResource() else { // Notice this line right here
                    return
                }
                do {
                    let data = try Data(contentsOf: url, options: .alwaysMapped)
                    let object = try JSONDecoder().decode(VideoListModel.self, from: data)
                    if let videoList = object.categories.first(where: { $0.name.lowercased() == "movies" })?.videos {
                        self.videoList = videoList
                        tableView.reloadData()
                    }
                } catch let err {
                    print("Exception \(err.localizedDescription)")
                    return
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoItemTableViewCell") as? VideoItemTableViewCell {
            cell.playabilityDelegate = self
            cell.displayCell(model: videoList[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
