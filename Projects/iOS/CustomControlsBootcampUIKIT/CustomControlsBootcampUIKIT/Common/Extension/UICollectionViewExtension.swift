//
//  UICollectionViewExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 09/06/23.
//

import UIKit

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}
