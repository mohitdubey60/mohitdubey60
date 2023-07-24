    //
    //  AllPhotosViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 05/08/22.
    //

import UIKit
import Photos

enum PhotoCellSize {
    case tall
    case normal
}

class AllPhotosViewController: UICollectionViewController {
    var allPhotos: PHFetchResult<PHAsset>?
    private var photos: [PhotoModel] = []
    @IBOutlet weak var photosCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SmallPhotoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SmallPhotoCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView?.collectionViewLayout as? WaterfallCollectionViewLayout {
            layout.delegate = self
        }
    }
    
    func reloadCollection() {
        Swift.print("Mohit: Photos count is \(allPhotos?.count)")
        photos = []
        for _ in 0..<(allPhotos?.count ?? 0) {
            photos.append(PhotoModel())
        }
        collectionView.reloadData()
    }
}

extension AllPhotosViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos?.count ?? 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallPhotoCollectionViewCell", for: indexPath) as? SmallPhotoCollectionViewCell {
            DispatchQueue.global(qos: .utility).async {[weak self] in
                if let asset = self?.allPhotos?.object(at: indexPath.item) {
                    PHPhotosUtility.shared.getImageFromAsset(asset: asset) { data, orientation in
                        if self?.photos[indexPath.item].imageData == nil {
                            self?.photos[indexPath.item].imageData = data
                            self?.photos[indexPath.item].orientation = orientation
                        }
                        cell.photoModel = self?.photos[indexPath.item] ?? PhotoModel()
                        cell.renderCell()
                    } failureHandler: {
                        
                    }
                }
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension AllPhotosViewController: WaterfallCollectionViewLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
            if photos[indexPath.item].photoSize == nil {
                let randomInt = Int.random(in: 0..<100)
                photos[indexPath.item].photoSize = randomInt % 5 == 0 ? .tall : .normal
            }
            
            let height = photos[indexPath.item].photoSize == .tall ? ((UIScreen.screenWidth - 3)/3) * 2 : ((UIScreen.screenWidth - 3)/3)
            return height
        }
    
}

//extension AllPhotosViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (UIScreen.screenWidth - 3)/3, height: (UIScreen.screenWidth - 3)/3);
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//}
