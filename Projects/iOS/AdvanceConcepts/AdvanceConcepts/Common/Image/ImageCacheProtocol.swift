//
//  ImageCacheProtocol.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import SwiftUI

protocol ImageCacheProtocol {
    func setImage(forStringUrl urlString: String, image: UIImage)
    func getImage(forStringUrl urlString: String) -> UIImage?
    func removeImage(forStringUrl urlString: String)
}
