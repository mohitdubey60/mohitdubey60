//
//  CompositeCollectionView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 12/11/22.
//

import SwiftUI

class CompositeCollectionViewController: UICollectionViewController {
    let cellId = "cellId"
    static let headerKindCell = "headerKindCell"
    let headerCell = "headerCell"
    
    init(){
        let compositeLayout = UICollectionViewCompositionalLayout { (sectionNumber, sectionEnvironemnt) -> NSCollectionLayoutSection? in
            let item = CompositeLayoutSectionAndItemMap.sectionItemMap[sectionNumber]
            let kindString = item?.headerString != nil ? CompositeCollectionViewController.headerKindCell : nil
            return CompositeLayoutFactory.makeLayoutSection(type: item?.layoutType ?? .grid4Column, kindString: kindString )
        }
        
        super.init(collectionViewLayout: compositeLayout)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderForGroupCollectionView.self, forSupplementaryViewOfKind: CompositeCollectionViewController.headerKindCell, withReuseIdentifier: headerCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: CompositeCollectionViewController.headerKindCell, withReuseIdentifier: headerCell, for: indexPath)
        if let h = header as? HeaderForGroupCollectionView {
            h.label.text = CompositeLayoutSectionAndItemMap.sectionItemMap[indexPath.section]?.headerString
        }
        
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CompositeLayoutSectionAndItemMap.sectionItemMap[section]?.itemCount ?? 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.random
        return cell
    }
}

class HeaderForGroupCollectionView: UICollectionReusableView {
    let label: UILabel
    override init(frame: CGRect) {
        label = UILabel()

        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct CompositeCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: CompositeCollectionViewController())
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
