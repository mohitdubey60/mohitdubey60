    //
    //  ProgressiveImage.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 17/07/23.
    //

import Foundation
import Combine

class ProgressiveImage: NSObject, URLSessionDataDelegate {
    static let nonPrimaryOperation: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.name = "com.ApplicationUtility.nonPrimaryOperation"
        operationQueue.qualityOfService = .utility
        return operationQueue
        }()
    
    private var urlObj: URLSession!
    private let publisher: PassthroughSubject<Data, Error> = PassthroughSubject<Data, Error>()
    
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        urlObj = URLSession(configuration: configuration, delegate: self, delegateQueue: ProgressiveImage.nonPrimaryOperation)
    }
    
    func getImage(from url: URL) -> PassthroughSubject<Data, Error> {
        let task = urlObj.dataTask(with: url)
        task.resume()
        
        return publisher
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DidRecieve \(data.count)")
        publisher.send(data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
    }
}
