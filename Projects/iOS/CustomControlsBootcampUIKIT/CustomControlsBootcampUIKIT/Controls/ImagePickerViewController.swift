//
//  ImagePickerViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 26/07/23.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .any(of: [.images])
        
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
