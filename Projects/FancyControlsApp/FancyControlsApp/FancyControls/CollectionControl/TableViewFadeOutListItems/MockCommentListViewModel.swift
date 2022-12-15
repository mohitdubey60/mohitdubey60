//
//  MockCommentListViewModel.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/12/22.
//

import UIKit

protocol CommentsProtocol: AnyObject {
    func dataReceived()
}

class MockCommentListViewModel {
    weak var delegate: CommentsProtocol?
    var comments: [MockCommentModel] = []
    
    private func readMockComments() {
        if let filepath = Bundle.main.path(forResource: "MockArray", ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: filepath)
                let jsonData = Data(jsonString.utf8)
                let decoder = JSONDecoder()
                
                do {
                    let people = try decoder.decode([MockCommentModel].self, from: jsonData)
                    print(people)
                    comments = people
                    delegate?.dataReceived()
                } catch {
                    print(error.localizedDescription)
                }
                
            } catch {
                    // contents could not be loaded
            }
        } else {
                // example.txt not found!
        }
    }
    
    init(delegate: CommentsProtocol) {
        self.delegate = delegate
    }
    
    func setCommentsDelegate(_ delegate: CommentsProtocol) {
        self.delegate = delegate
    }
    
    func getComments() {
        DispatchQueue.global().async {[weak self] in
            self?.readMockComments()
        }
    }
}
