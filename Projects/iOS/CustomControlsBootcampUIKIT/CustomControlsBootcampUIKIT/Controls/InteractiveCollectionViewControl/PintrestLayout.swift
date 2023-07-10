//
//  PintrestLayout.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 14/06/23.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PintrestLayout: UICollectionViewLayout {
    weak var delegate: PinterestLayoutDelegate?
    
    private let numberOfColumns: Int
    private let cellPadding: CGFloat
    
    private var contentHeight: CGFloat = 0
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    init(delegate: PinterestLayoutDelegate? = nil, numberOfColumns: Int,
         cellPadding: CGFloat) {
        self.delegate = delegate
        self.numberOfColumns = numberOfColumns
        self.cellPadding = cellPadding
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        numberOfColumns = 2
        cellPadding = 6
        
        super.init()
    }
    
    var contentWidth: CGFloat {
        guard let collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        let width = collectionView.bounds.width - (insets.left + insets.right)
        
        return width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func prepare() {
        guard let collectionView else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        var column = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
            
            let cellHeight = (cellPadding * 2) + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + cellHeight
            
            column = column % 2 == 0 ? 1 : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
}
