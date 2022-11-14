//
//  CompositeLayoutFactory.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 13/11/22.
//

import UIKit

enum CompositeLayoutTypes {
    case pager300
    case grid4Column
    case horizontalListWidthRectangles
    case grid2Column
}

class CompositeLayoutFactory {
    class func makeLayoutSection(type sectionType: CompositeLayoutTypes, kindString: String? = nil) -> NSCollectionLayoutSection {
        var section: NSCollectionLayoutSection!
        switch sectionType {
            case .pager300:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 4
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(200)),
                                                               subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets.bottom = 8
            case .grid4Column:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25),
                                                                    heightDimension: .absolute(150)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .estimated(300)),
                                                               subitems: [item])
                group.contentInsets.leading = 12
                group.contentInsets.trailing = 12
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 8
            case .horizontalListWidthRectangles:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.95),
                                                                    heightDimension: .fractionalHeight(1)))
                item.contentInsets.top = 4
                item.contentInsets.bottom = 4
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.75),
                                                                                 heightDimension: .absolute(100)),
                                                               subitems: [item])
                group.contentInsets.leading = 16
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 8
                
            case .grid2Column:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                    heightDimension: .fractionalWidth(0.75)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .estimated(300)),
                                                               subitems: [item])
                group.contentInsets.leading = 12
                group.contentInsets.trailing = 12
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 8
        }
        
        if let kString = kindString {
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                          heightDimension: .absolute(50)),
                                                        elementKind: kString, alignment: .topLeading)]
            section.boundarySupplementaryItems.first?.contentInsets.leading = 16
        } else {
            section.boundarySupplementaryItems = []
        }
        return section
    }
    
    class func makeGalleryLayoutSection() -> NSCollectionLayoutSection {
       
        let pagerItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
        pagerItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let groupInner2HorizontalSplitItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        groupInner2HorizontalSplitItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupInner2HorizontalSplit = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [groupInner2HorizontalSplitItem])
        
        let groupInner2VerticalSplitItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        groupInner2VerticalSplitItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupInner2VerticalSplit = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitems: [groupInner2VerticalSplitItem, groupInner2HorizontalSplit])
        
        let group2SplitItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        group2SplitItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let group2Split = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [group2SplitItem, groupInner2VerticalSplit])
        
        let group3SplitItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        group3SplitItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let group3Split = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [group3SplitItem])
        
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(600)), subitems: [pagerItem, group2Split, group3Split])
        let section = NSCollectionLayoutSection(group: containerGroup)
        return section
    }
}
