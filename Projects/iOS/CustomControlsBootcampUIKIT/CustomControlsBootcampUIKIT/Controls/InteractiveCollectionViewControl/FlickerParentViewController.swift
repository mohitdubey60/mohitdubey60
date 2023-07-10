//
//  FlickerParentViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 08/06/23.
//

import UIKit
import SwiftUI

//MARK: - Custom protocol to interact with Collection view
protocol FlickrCollectionActions: AnyObject {
    func loadPhoto(photo: FlickrSearchPhoto, completion: @escaping (Data?, FlickrSearchPhoto) -> Void)
    func loadCells(with photosViewModel: [FlickrCellViewModel])
    func updateShareVisibility(show isVisible: Bool)
}

//MARK: - View for section header
class FlickrSectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderLabel: UILabel!
}

//MARK: - View for Collection view cells
class FlickerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var flickerImage: UIImageView!
    weak var delegate: FlickrCollectionActions?
    var viewModel: FlickrCellViewModel!

    
    override func prepareForReuse() {
        flickerImage.image = nil
    }
    
    fileprivate func loadImage(_ imageData: Data) {
        DispatchQueue.main.async {[weak self] in
            self?.flickerImage.image = nil
            self?.flickerImage.image = UIImage(data: imageData)
        }
    }
    
    private func addRemoveSelectOverlay() {
        if viewModel.isSelected {
            if let subView = self.subviews.filter({ $0.tag == 1111 }).first as? UIView {
                subView.removeFromSuperview()
            }
            
            let overlayView = UIView()
            overlayView.tag = 1111
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(overlayView)
            
            overlayView.backgroundColor = .red
            overlayView.alpha = 0.4
            
            NSLayoutConstraint.activate([
                overlayView.heightAnchor.constraint(equalTo: self.heightAnchor),
                overlayView.widthAnchor.constraint(equalTo: self.widthAnchor),
                overlayView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                overlayView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        } else if let subView = self.subviews.filter({ $0.tag == 1111 }).first as? UIView {
            subView.removeFromSuperview()
        }
        
        layoutIfNeeded()
    }
    
    func displayData(photoVM: FlickrCellViewModel) {
        self.viewModel = photoVM
        flickerImage.image = nil
        delegate?.loadPhoto(photo: self.viewModel.photo, completion: {[weak self] data, returnedPhoto in
            if self?.viewModel.photo.photoUrl == returnedPhoto.photoUrl, let imageData = data {
                self?.loadImage(imageData)
            }
        })
        
        addRemoveSelectOverlay()
    }
    
    func updateView(photoVM: FlickrCellViewModel) {
        self.viewModel = photoVM
        addRemoveSelectOverlay()
    }
}

//MARK: - CollectionView controller
class FlickerParentViewController: UIViewController {

    @IBOutlet weak var flickerCollectionView: UICollectionView!
    @IBOutlet weak var shareUIView: IBDesignableCustomView!
    @IBOutlet weak var shareItemCountLabel: UILabel!
    var viewModel: FlickerCollectionViewModel!
    let itemsPerRow = 3
    
    private let heightArray = [90, 180, 270]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FlickerCollectionViewModel(service: FlickerImageSearchService(pageSize: 20,
                                                                                imageCacheManager: ImageCacheManager()), itemsPerRow: itemsPerRow)
        viewModel.delegate = self
        viewModel.getAllPhotos()
        
        //Add this delegate to set up the source of data for the collectionView
        flickerCollectionView.dataSource = self
        //Add this delegate to listen to flowLayout and other actions like drag, drop, selection, etc
        flickerCollectionView.delegate = self
        
        flickerCollectionView.collectionViewLayout = PintrestLayout(delegate: self, numberOfColumns: 2, cellPadding: 6)
        
        flickerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        flickerCollectionView.allowsMultipleSelection = true
                
        flickerCollectionView.dragInteractionEnabled = true
        flickerCollectionView.dragDelegate = self
        flickerCollectionView.dropDelegate = self
        
        updateShareVisibility(show: viewModel.selectedItems.count > 0)
        shareUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareImages)))
    }
    
    @objc func shareImages() {
        let images = viewModel.selectedItems.compactMap({
            if let index = viewModel.photosViewModel.firstIndex(of: $0 ),
                let cell = flickerCollectionView.cellForItem(at: IndexPath(item: index, section: 0))
                as? FlickerCollectionViewCell {
                
                return cell.flickerImage.image
            }
            
            return nil
        })
        
        guard !images.isEmpty else {
            return
        }
        
        let shareController = UIActivityViewController(
            activityItems: images,
            applicationActivities: nil)
        
        shareController.completionWithItemsHandler = {[weak self] _, _, _, _ in
            self?.viewModel.deSelectAll()
            self?.flickerCollectionView.deselectAllItems(animated: true)
        }
        
        shareController.popoverPresentationController?.sourceView = shareUIView
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        present(shareController, animated: true, completion: nil)
    }
}

//MARK: - CollectionView Data source methods
extension FlickerParentViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(FlickrSectionHeaderView.self)", for: indexPath) as? FlickrSectionHeaderView {
                    
                    headerView.sectionHeaderLabel.text = "House"
                    
                    return headerView
                }
                
                return UICollectionReusableView()
            default:
                return UICollectionReusableView()
                assert(false, "Invalid element type in Supplement view")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FlickerCollectionViewCell.self)", for: indexPath) as? FlickerCollectionViewCell, let vm = viewModel else {
            #warning("This can throw and exception, Use a registered cell here")
            return UICollectionViewCell()
        }
        if vm.photosViewModel.count > indexPath.item {
            cell.delegate = self
            cell.displayData(photoVM: vm.photosViewModel[indexPath.item])
        }
        
        return cell
    }
}

//MARK: - CollectionView Flow layout methods methods
extension FlickerParentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (view.frame.width - 12 - CGFloat((itemsPerRow + 1) * 3)) / CGFloat(viewModel.itemsPerRow)
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

//MARK: - Collection view actions handle
extension FlickerParentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FlickerCollectionViewCell else {
            return
        }
        
        if viewModel.photosViewModel.count > indexPath.item {
            viewModel.selectItem(at: indexPath.item)
            cell.updateView(photoVM: viewModel.photosViewModel[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FlickerCollectionViewCell else {
            return
        }
        
        if viewModel.photosViewModel.count > indexPath.item {
            viewModel.removeItem(at: indexPath.item)
            cell.updateView(photoVM: viewModel.photosViewModel[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let localCell = cell as? FlickerCollectionViewCell else {
            return
        }
        
        print("Mohit: willDisplay \(localCell.viewModel.photo.id)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let localCell = cell as? FlickerCollectionViewCell else {
            return
        }
        
        print("Mohit: didEndDisplaying \(localCell.viewModel.photo.id)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let localView = view as? FlickrSectionHeaderView else {
            return
        }
        
        print("Mohit: willDisplaySupplementaryView \(localView.sectionHeaderLabel.text)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        guard let localView = view as? FlickrSectionHeaderView else {
            return
        }
        
        print("Mohit: didEndDisplayingSupplementaryView \(localView.sectionHeaderLabel.text)")
    }
}

extension FlickerParentViewController {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("Mohit: scrollViewWillBeginDecelerating")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Mohit: scrollViewWillBeginDragging")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Mohit: scrollViewDidEndDragging")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Mohit: scrollViewDidEndDecelerating")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("Mohit: scrollViewDidEndScrollingAnimation")
    }
}

extension FlickerParentViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FlickerCollectionViewCell,
              let photo = cell.flickerImage.image else {
            return []
        }
        
        let item = NSItemProvider(object: photo)
        let dragItem = UIDragItem(itemProvider: item)
        
        return [dragItem]
    }
}

extension FlickerParentViewController: UICollectionViewDropDelegate {
    func removePhoto(at indexPath: IndexPath) {
        viewModel.photosViewModel.remove(at: indexPath.item)
    }
    
    func insertPhoto(_ flickrPhotoVM: FlickrCellViewModel, at indexPath: IndexPath) {
        viewModel.photosViewModel.insert(flickrPhotoVM, at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else {
                return
            }
            if self.viewModel.photosViewModel.count > sourceIndexPath.item {
                
                self.flickerCollectionView.performBatchUpdates {
                    let photosVM = self.viewModel.photosViewModel[sourceIndexPath.item]
                        removePhoto(at: sourceIndexPath)
                        insertPhoto(photosVM, at: destinationIndexPath)
                        self.flickerCollectionView.deleteItems(at: [sourceIndexPath])
                        self.flickerCollectionView.insertItems(at: [destinationIndexPath])
                    } completion: { _ in
                        coordinator.drop(dropItem.dragItem,
                                         toItemAt: destinationIndexPath)
                }

            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move,
                                            intent: .insertAtDestinationIndexPath)
    }
}


//MARK: - Custom protocol implementation
extension FlickerParentViewController: FlickrCollectionActions {
    func loadPhoto(photo: FlickrSearchPhoto, completion: @escaping (Data?, FlickrSearchPhoto) -> Void) {
        Task.init {
            do {
                if let result = try await viewModel?.getImageForCell(photo:photo) {
                    completion(result.data, result.photoModel)
                }
            } catch {
                completion(nil, photo)
            }
        }
    }
    
    func loadCells(with photosViewModel: [FlickrCellViewModel]) {
        flickerCollectionView.reloadData()
    }
    
    func updateShareVisibility(show isVisible: Bool) {
        shareUIView.isHidden = !isVisible
        shareItemCountLabel.text = "\(viewModel.selectedItems.count)"
    }
}

extension FlickerParentViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        CGFloat(heightArray.randomElement() ?? heightArray[0])
    }
}

//MARK: - SwiftUI Preview
//struct FlickerParentViewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = FlickerParentViewController
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//
//    func makeUIViewController(context: Context) -> UIViewControllerType {
//        let controller = UIStoryboard(name: "Controls", bundle: nil).instantiateViewController(withIdentifier: "\(UIViewControllerType.self)") as! UIViewControllerType
//        return controller
//    }
//}
//
//struct FlickerParentViewController_Previews: PreviewProvider {
//    static let devices: [String] = ["iPhone SE",
//                                    "iPhone 11 Pro Max",
//                                    "iPad Pro (11-inch)"]
//    static var previews: some View {
//        ForEach(FlickerParentViewController_Previews.devices, id: \.self) { device in
//            FlickerParentViewControllerRepresentable()
//                .previewDevice(PreviewDevice(rawValue: device))
//                .previewDisplayName(device)
//        }
//    }
//}
