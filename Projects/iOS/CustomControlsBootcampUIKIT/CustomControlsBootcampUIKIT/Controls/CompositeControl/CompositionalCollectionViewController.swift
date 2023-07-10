    //
    //  CompositeCollectionViewController.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 09/05/23.
    //

import UIKit
import SwiftUI

private let reuseIdentifier = "Cell"

class CompositionalCollectionViewController: UICollectionViewController {
    
    let colors: [UIColor] = [.systemRed, .systemBlue, .black, .systemYellow]
    var layoutConfig: CompositionalCollectionViewConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutConfig = CompositionalCollectionViewConfig(layoutConfig: .fourBoxOneBox)
        
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
        
            // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.collectionViewLayout = layoutConfig.compositionalLayout
            // Do any additional setup after loading the view.
    }
    
        // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
            // Configure the cell
        
        let index = indexPath.item % 4
        cell.backgroundColor = colors[index]
        
        return cell
    }
}

//struct CompositionalCollectionViewControllerRepresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: CompositionalCollectionViewController, context: Context) {
//
//    }
//
//    typealias UIViewControllerType = CompositionalCollectionViewController
//
//    func makeUIViewController(context: Context) -> CompositionalCollectionViewController {
//        let controller = UIStoryboard(name: "Controls", bundle: nil).instantiateViewController(withIdentifier: "CompositionalCollectionViewController") as! CompositionalCollectionViewController
//        return controller
//    }
//}
//
//struct CompositionalCollectionViewController_Previews: PreviewProvider {
//    static let devices: [String] = ["iPhone SE",
//                             "iPhone 11 Pro Max",
//                             "iPad Pro (11-inch)"]
//    static var previews: some View {
//        ForEach(CompositionalCollectionViewController_Previews.devices, id: \.self) { device in
//            CompositionalCollectionViewControllerRepresentable()
//                .previewDevice(PreviewDevice(rawValue: device))
//                .previewDisplayName(device)
//        }
//
//
//    }
//}
