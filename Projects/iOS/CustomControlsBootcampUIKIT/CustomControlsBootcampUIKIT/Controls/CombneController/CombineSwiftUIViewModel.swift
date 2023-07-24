//
//  CombineSwiftUIViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 16/07/23.
//

import SwiftUI
import Combine

class CombineSwiftUIViewModel: ObservableObject {
    private var cancellableStore = Set<AnyCancellable>()
    private let progressive = ProgressiveImage()
    
    @Published var uiimage: UIImage?
    var data = Data()
    
    deinit {
        for cancellableItem in cancellableStore {
            cancellableItem.cancel()
        }
        
        cancellableStore = Set<AnyCancellable>()
    }
    
    func getContent(of fileName: String) {
        @FileWithUrl(fileNameWithExtension: fileName)
        var fileURL: URL?
        if let fileURL {
            FilePublisher(fileURL: fileURL)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            print("Error in reading file \(error.localizedDescription)")
                    }
                } receiveValue: { fileData in
                    print("Received data \(String(decoding: fileData, as: UTF8.self))")
                }
                .store(in: &cancellableStore)
        }
    }
    
    func getImage() {
        if let url = URL(string: "https://edmullen.net/test/rc.jpg") {
            progressive.getImage(from: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print("Completion \(completion)")
                } receiveValue: { data in
                    print("Data is \(data.count)")
                    self.data += data
                    self.uiimage = UIImage(data: self.data)
                }
                .store(in: &cancellableStore)

        }
        
    }
    
    func getUsers() {
        let users = [
            User(name: "Mohit", age: 34),
            User(name: "Garima", age: 33),
            User(name: "Khushi", age: 25)
        ]
        
        let result = users.average(\.age)
        let allUsers = users.map(\.name)
        print("Average age is \(result), users are \(allUsers)")
    }
}

struct User {
    let name: String
    let age: Int
}
