    //
    //  FlickerImageSearchService.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 08/06/23.
    //

import Foundation
import Combine

enum FlickrImageSize: String {
    case smallSquare = "s"
    case small = "w"
    case thumbnail = "t"
    case original = "o"
}

class FlickerImageSearchService {
    let apiKey = "63d68e9e3548dcd274f98a9e60c401ba"
        //https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(searchTag)&per_page=20&format=json&nojsoncallback=1
        //https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg
    let pageSize: Int
    var page: Int = 0
    var subscribers: Set<AnyCancellable> = Set<AnyCancellable>()
    let imageCacheManager: ImageCacheManager
    
    init(pageSize: Int, imageCacheManager: ImageCacheManager) {
        self.pageSize = pageSize
        self.imageCacheManager = imageCacheManager
    }
    
    deinit {
        subscribers.removeAll()
    }
    
    func searchImagesFor(tag searchTag: String, completion: @escaping ([FlickrSearchPhoto], Error?)->Void) {
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(searchTag)&per_page=\(pageSize)&page=\(page+1)&format=json&nojsoncallback=1"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global())
                .sink { (combineCompletion) in
                    switch combineCompletion {
                        case .finished:
                            break
                        case .failure(let error):
                            print("Mohit: Error -> \(error.localizedDescription)")
                            completion([], error)
                    }
                } receiveValue: {[weak self] (flickrSearch: FlickrSearchParentModel) in
                    self?.page = flickrSearch.photos.page
                    let photos: [FlickrSearchPhoto] = flickrSearch.photos.photo
                    completion(photos, nil)
                }
                .store(in: &subscribers)
        }
    }
    
    //Reference from: https://www.flickr.com/services/api/misc.urls.html
    func getImage(for photo: FlickrSearchPhoto, size: FlickrImageSize) async throws ->  (Data?, FlickrSearchPhoto) {
        let photoUrl = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_\(size.rawValue).jpg"
        do {
            let imageData = try await imageCacheManager.getImage(url: photoUrl)
            return (imageData, photo)
        } catch(let err) {
            print("Mohit: Error is \(err.localizedDescription)")
            throw err
        }
    }
}
