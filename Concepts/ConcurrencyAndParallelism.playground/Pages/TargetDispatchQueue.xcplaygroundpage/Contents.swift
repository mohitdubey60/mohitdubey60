    //: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
  
    ///Get Queue name
extension DispatchQueue {
    static var currentLabel: String? {
        let name = __dispatch_queue_get_label(nil)
        return String(cString: name, encoding: .utf8)
    }
}
///Setting queue with target
///When we set a target to queue then it will inherit the restrictions of parent (target) queue.
///For eg: If target queue is inactive and serial then the child queue also will behave serially and will not start
///executing unless parent will be activated
/*
 Expected output
 
 Execution start
 Printing from parentBlock 3
 Printing from parentBlock 4
 Printing from parentBlock 5
 Execution end
 Printing in secondQueue
 Printing from firstQueue 0
 Printing from firstQueue 1
 Printing from firstQueue 2
 Printing from firstQueue - activated secondQueue
*/
func executeQueueWithTarget() {
    let firstQueue = DispatchQueue(label: "com.dispatchqueue.firstqueue", qos: .default, attributes: [.initiallyInactive])
    let secondQueue = DispatchQueue(label: "com.dispatchqueue.secondqueue", qos: .default, attributes: [.concurrent], target: firstQueue)

//    let secondQueue = DispatchQueue(label: "com.dispatchqueue.secondqueue", qos: .default, attributes: [.concurrent, .initiallyInactive], target: firstQueue)
    
    print("Execution start")
    secondQueue.async {
        print("Printing in secondQueue \(DispatchQueue.currentLabel)")
    }
    
        //firstQueue
    for i in 0..<3 {
        firstQueue.async {
            print("Printing from firstQueue \(i)")
        }
    }
    
    
    for i in 3..<6 {
        print("Printing from parentBlock \(i)")
    }
    
    firstQueue.async {
//        secondQueue.activate()
        print("Printing from firstQueue - activated secondQueue")
    }
    
    firstQueue.activate()
    print("Execution end")
}
executeQueueWithTarget()

    //: [Next](@next)
