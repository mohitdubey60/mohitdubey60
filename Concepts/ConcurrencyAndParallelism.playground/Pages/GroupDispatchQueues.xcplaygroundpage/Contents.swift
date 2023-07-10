//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


///DispatchGroup is used to club multiple dispatchRequests and notifiy on completion of all
///DispatchGroup can have same or different DispatchQueues grouped
///Only necessary thing is to make balanced calls to enter() and leave() on a dispatch group to have it synchronize our tasks.
///Call enter() to manually notify the group that a task has started and leave() to notify that work has been done.
///call group.wait() too which blocks the current thread until the group’s tasks have completed.
///wait(timeout:). This blocks the current thread, but after the timeout specified, continues anyway. To create a timeout object of type DispatchTime, the syntax .now() + 1 will create a timeout one second from now.
///wait(timeout:) returns an enum that can be used to determine whether the group completed, or timed out.

/*
Expected output -> note: Download sequence may change depending on images
 
 ###### Download all images asynchronously and notify on completion ######
 ############
 ############
 
 Image 0 download queued
 Image 1 download queued
 Image 2 download queued
 Image 3 download queued
 Image 4 download queued
 Image 5 download queued
 Image 6 download queued
 Image 7 download queued
 Image 8 download queued
 Image 9 download queued
 Image 6 downloaded
 Image 9 downloaded
 Image 5 downloaded
 Image 4 downloaded
 Image 0 downloaded
 Image 3 downloaded
 Image 8 downloaded
 Image 1 downloaded
 Image 2 downloaded
 Image 7 downloaded
 All Image download completed
*/

/*
 Using wait() and then execute completion block on main queue Or
 Call group notify()
 
 The only issue with timeout is that the tasks are not cancelled. We only get a notification of timeout
*/
func executeToNotifyWhenAllImageDownloadCompletes(_ completion: @escaping () -> (), _ failure: @escaping () -> ()) {
    let queue = DispatchQueue(label: "com.dispatchqueue.queue", attributes: [.concurrent])
    let imageGroupQueue = DispatchGroup()
    
    for i in 0..<10 {
        print("Image \(i) download queued")
        imageGroupQueue.enter()
        queue.async {
            let image = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Image \(i) downloaded")
            imageGroupQueue.leave()
        }
    }
    //We can either use group.wait or group.notify.
//    imageGroupQueue.wait()
//    DispatchQueue.main.async {
//        completion()
//    }
    
    //If we want to wait only for a certain duration then use wait with timeout
    let result = imageGroupQueue.wait(timeout: .now() + 0.1)

    switch result {
        case .success:
            DispatchQueue.main.async {
                completion()
            }
        case.timedOut:
            failure()
    }
    
//    imageGroupQueue.notify(queue: DispatchQueue.main) {
//        completion()
//    }
}
print("###### Download all images asynchronously and notify on completion ######")
print("############")
print("############\n")

executeToNotifyWhenAllImageDownloadCompletes {
    print("All Image download completed")
} _: {
    print("Image download timedOut")
}



//: [Next](@next)
