    //
    //  PhotosGalleryHomeViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 05/08/22.
    //

import UIKit
import Photos

class PhotosGalleryHomeViewController: UIViewController {
    private var allPhotos = PHFetchResult<PHAsset>()
    
    fileprivate func loadAllPhotos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        let result = PHAsset.fetchAssets(with: allPhotosOptions)
        
        if let allPhotosVC = UIStoryboard.getViewController(fromStoryboard: StoryboardName.photos.rawValue, controllerIdentifier: AllPhotosViewController.self) {
            addChild(allPhotosVC)
            view.addSubview(allPhotosVC.view)
            allPhotosVC.view.frame = view.bounds
            didMove(toParent: allPhotosVC)
            allPhotosVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([NSLayoutConstraint(item: allPhotosVC.view!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                                         NSLayoutConstraint(item: allPhotosVC.view!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                                         NSLayoutConstraint(item: allPhotosVC.view!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                                         NSLayoutConstraint(item: allPhotosVC.view!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)])
            allPhotosVC.allPhotos = result
            allPhotosVC.reloadCollection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Do any additional setup after loading the view.
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
                
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) {[weak self] status in
                    if status == .authorized || status == .limited {
                        self?.loadAllPhotos()
                    }
                }
            case .restricted, .denied:
                Swift.print("Mohit: Open settings")
            case .authorized, .limited:
                loadAllPhotos()
            @unknown default:
                Swift.print("Mohit: Open settings")
        }
    }
    
}
