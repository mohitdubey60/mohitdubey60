//
//  CompositeCollectionViewConfig.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 09/05/23.
//

import UIKit

enum CompositionalCollectionLayoutConfigOptions {
    case threeColumns
    case fourBoxOneBox
    case twoVBoxOneBoxTwoVBox
    case fourBoxOneBoxAndThreeHBoxOneBoxTwoVBoxOneBoxSixBox
}

struct CompositionalCollectionViewConfig {
    let layoutConfig: CompositionalCollectionLayoutConfigOptions
    
    lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        switch layoutConfig {
            case .threeColumns:
                return UICollectionViewCompositionalLayout(section: threeColumns)
            case .fourBoxOneBox:
                return UICollectionViewCompositionalLayout(section: fourBoxOneBox)
            default:
                return UICollectionViewCompositionalLayout(section: threeColumns)
        }
    }()
    
    init(layoutConfig: CompositionalCollectionLayoutConfigOptions) {
        self.layoutConfig = layoutConfig
        
    }
}

extension CompositionalCollectionViewConfig {
    var threeColumns: NSCollectionLayoutSection {
        let fraction: CGFloat = 1/3
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    var fourBoxOneBox: NSCollectionLayoutSection {
        let inset: CGFloat = 0.5

        let verticalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(2/3))
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
        verticalItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let twoBoxItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2))
        let twoBoxItem = NSCollectionLayoutItem(layoutSize: twoBoxItemSize)
            twoBoxItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        let twoBoxGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .fractionalWidth(1/2))
        let twoBoxGroup = NSCollectionLayoutGroup.horizontal(layoutSize: twoBoxGroupSize, subitems: [twoBoxItem])
        
        let vTwoBoxGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        let vTwoBoxGroup = NSCollectionLayoutGroup.vertical(layoutSize: vTwoBoxGroupSize, subitems: [twoBoxGroup])
        
        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
        let fullGroup = NSCollectionLayoutGroup.horizontal(layoutSize: fullGroupSize, subitems: [vTwoBoxGroup, verticalItem])
        
        let reverseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: fullGroupSize, subitems: [verticalItem, vTwoBoxGroup])
        
        let completeCollectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(4/3))
        let completeCollection = NSCollectionLayoutGroup.vertical(layoutSize: completeCollectionSize, subitems: [fullGroup, reverseGroup])
        
        let section = NSCollectionLayoutSection(group: completeCollection)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        return section
    }
}
