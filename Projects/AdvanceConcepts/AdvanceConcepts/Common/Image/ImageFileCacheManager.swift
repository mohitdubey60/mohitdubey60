//
//  ImageFileCacheManager.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import SwiftUI

class ImageFileCacheManager: ImageCacheProtocol {
    private let removePreviousStoredFiles = false
    static let shared: ImageFileCacheManager = ImageFileCacheManager()
    private init() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else {
                return
            }
            
            self.createFolderIfNeeded()
            if self.removePreviousStoredFiles == true {
                self.removeAllImages()
            }
        }
        
    }
    
    private let folderName = "AdvanceConceptImages"
    
    private func createFolderIfNeeded() {
        if let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let folderPath = cachePath.appending(component: folderName)
            if !FileManager.default.fileExists(atPath: folderPath.path()) {
                do {
                    try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: false)
                } catch let error {
                    print("Error in CreateDirectory \(error)")
                }
            }
        }
    }
    
    private func getImageDirectoryPath() -> URL? {
        if let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let folderPath = cachePath.appending(component: folderName)
            if FileManager.default.fileExists(atPath: folderPath.path()) {
                return folderPath
            }
        }
        
        return nil
    }
    
    func setImage(forStringUrl urlString: String, image: UIImage) {
        DispatchQueue.global(qos: .background).async {[weak self] in
            if let imageUrl = URL(string: urlString),
               let directoryPath = self?.getImageDirectoryPath() {
                
                    //Very specific handling for same image name with different sizes
                    //Eg url: https://via.placeholder.com/150/92c952
                let imageName = "\(imageUrl.lastPathComponent)_\(imageUrl.pathComponents[imageUrl.pathComponents.count - 2])"
                
                let imageData = image.pngData()
                let imagePath = directoryPath.appending(component: imageName).appendingPathExtension("png").path()
                
                let isFileCreated = FileManager.default.createFile(atPath: imagePath, contents: imageData)
                
                if isFileCreated {
                    return
                }
            }
            
            print("File creation failed!")
        }
    }
    
    func getImage(forStringUrl urlString: String) -> UIImage? {
        if let imageUrl = URL(string: urlString),
           let directoryPath = getImageDirectoryPath() {
                
                //Very specific handling for same image name with different sizes
                //Eg url: https://via.placeholder.com/600/92c952
            let imageName = "\(imageUrl.lastPathComponent)_\(imageUrl.pathComponents[imageUrl.pathComponents.count - 2])"
            
            let imagePath = directoryPath.appending(component: imageName).appendingPathExtension("png")
            if FileManager.default.fileExists(atPath: imagePath.path()) {
                print("Reading image from file \(imageName) -> \(imagePath.path())")
                do {
                    let data = try Data(contentsOf: imagePath)
                    let image = UIImage(data: data)
                    return image
                } catch let error {
                    print("Error in reading file from \(urlString) Error: \(error)")
                }
            }
        }
        
        return nil
    }
    
    func removeImage(forStringUrl urlString: String) {
        if let imageUrl = URL(string: urlString),
           let directoryPath = getImageDirectoryPath() {
            let imageName = imageUrl.lastPathComponent
            
            let imagePath = directoryPath.appending(component: imageName).appendingPathExtension("png")
            do {
                try FileManager.default.removeItem(at: imagePath)
            } catch let error {
                print("Error in reading file from \(urlString) Error: \(error)")
            }
        }
    }
    
    func removeAllImages() {
        if let directoryUrl = getImageDirectoryPath() {
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: directoryUrl,
                                                                           includingPropertiesForKeys: nil,
                                                                           options: .skipsHiddenFiles)
                print("Attempting to delete \(fileURLs.count) files")
                for fileURL in fileURLs {
                    try FileManager.default.removeItem(at: fileURL)
                }
            } catch  {
                print("Error delete file \(error)")
            }
        }
    }
}
