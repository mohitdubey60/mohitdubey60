//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let concurrentQueue = DispatchQueue(label: "com.dispatchQueue.concurrentQueue", attributes: [.concurrent])

func executeWorkItemWithCancel(success: @escaping () -> (), failure: @escaping () -> ()) -> DispatchWorkItem? {
    var task: DispatchWorkItem?
    task = DispatchWorkItem(flags: [.assignCurrentContext]) {
        for i in 0..<10 {
            print("Image \(i) download started")
            
            if task?.isCancelled == true {
                print("Image \(i) cancelled")
                failure()
                break
            }
            let image = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Image \(i) downloaded")
        }
    }
    
    task?.notify(queue: concurrentQueue) {
        success()
    }
    
    return task
}

if let task = executeWorkItemWithCancel(success: {
    print("Work item completed")
}, failure: {
    print("Image download failure due to timeout")
}) {
    concurrentQueue.async {
        task.wait(wallTimeout: .now() + .milliseconds(500))
        print("About to start the task")
        task.perform()
    }
    
    concurrentQueue.asyncAfter(deadline: .now() + .seconds(1)) {
        print("About to cancel the task")
        task.cancel()
    }
}

//: [Next](@next)
