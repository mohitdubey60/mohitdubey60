//
//  CompositeCollectionViewGalleryView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 13/11/22.
//

import SwiftUI

class CompositeCollectionViewGalleryViewController: UICollectionViewController {
    let cellId = "cellId"
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            CompositeLayoutFactory.makeGalleryLayoutSection()
        }
        super.init(collectionViewLayout: layout)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 112
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct CompositeCollectionViewGalleryView: View {
    var body: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: CompositeCollectionViewGalleryViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
        
        typealias UIViewControllerType = UIViewController
    }
}

struct CompositeCollectionViewGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeCollectionViewGalleryView()
    }
}
