//: [Previous](@previous)

import Foundation

///A semaphore consists of a threads queue and a counter value (of type Int).
///Threads queue is used by the semaphore to keep track on waiting threads in FIFO order.
///Counter value is used by the semaphore to decide if a thread should get access to a shared resource or not. The counter value changes when we call signal() or wait() functions.
///Request the shared resource:
///Call wait() each time before using the shared resource. We are basically asking the semaphore if the shared resource is available or not. If not, we will wait.
///wait() -> Decrement semaphore counter by 1
///
///Release the shared resource
///Call signal() each time after using the shared resource. We are basically signaling the semaphore that we are done interacting with the shared resource.
///signal() -> Increment semaphore counter by 1


///If the previous value is equal or bigger than zero, it means thread queue is empty, no one is waiting.
/*
 Expected output
 
 #block1 -> 0 -> Waiting
 #block1 -> 1 -> Waiting
 #block1 -> 2 -> Waiting
 #block3 -> 6 -> Waiting
 #block1 -> 0 -> Wait finished
 #block3 -> 7 -> Waiting
 #block3 -> 8 -> Waiting
 Printing values from #block1 -> 0 -> Optional(8965)
 #block1 -> 2 -> Wait finished
 Printing values from #block1 -> 2 -> Optional(8700)
 #block1 -> 1 -> Wait finished
 Printing values from #block1 -> 1 -> Optional(14252)
 #block3 -> 6 -> Wait finished
 Printing values from #block3 -> 6 -> Optional(8693)
 #block3 -> 7 -> Wait finished
 Printing values from #block3 -> 7 -> Optional(14252)
 #block3 -> 8 -> Wait finished
 Printing values from #block3 -> 8 -> Optional(11471)
*/
func executeFuncWithSemaphore() {
    let concurrentQueue = DispatchQueue(label: "com.dispatchqueue.concurrentqueue", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit)
    let semaphore = DispatchSemaphore(value: 1)
    
    for i in 0..<3 {
        concurrentQueue.async {
            print("#block1 -> \(i) -> Waiting")
            semaphore.wait()
            print("#block1 -> \(i) -> Wait finished")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block1 -> \(i) -> \(data?.count)")
            semaphore.signal()
        }
    }
    
//    for i in 3..<6 {
//        concurrentQueue.async {
//            print("Printing values from #block2 -> \(i) -> Start")
//            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
//            print("Printing values from #block2 -> \(i) -> \(data?.count)")
//        }
//    }
    
    for i in 6..<9 {
        concurrentQueue.async {
            print("#block3 -> \(i) -> Waiting")
            semaphore.wait()
            print("#block3 -> \(i) -> Wait finished")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
            semaphore.signal()
        }
    }
}
//executeFuncWithSemaphore()
//: [Next](@next)

///DispatchSemaphore(value: <Number>) the positive number here will decide how many executions
///Since we are allowing 2 here so two threads can be executed concurrently here
/*
 #block1 -> 0 -> Waiting
 #block1 -> 1 -> Waiting
 #block1 -> 2 -> Waiting
 #block3 -> 6 -> Waiting
 #block3 -> 7 -> Waiting
 #block1 -> 0 -> Wait finished
 #block3 -> 6 -> Wait finished
 #block3 -> 8 -> Waiting
 Printing values from #block3 -> 6 -> Optional(8114)
 #block3 -> 7 -> Wait finished
 Printing values from #block3 -> 7 -> Optional(9306)
 #block1 -> 2 -> Wait finished
 Printing values from #block1 -> 2 -> Optional(17628)
 #block1 -> 1 -> Wait finished
 Printing values from #block1 -> 1 -> Optional(24365)
 #block3 -> 8 -> Wait finished
 Printing values from #block1 -> 0 -> Optional(5473)
 Printing values from #block3 -> 8 -> Optional(9900)
*/
func executeFuncWithSemaphoreMultipleExecutions() {
    let concurrentQueue = DispatchQueue(label: "com.dispatchqueue.concurrentqueue", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit)
    let semaphore = DispatchSemaphore(value: 2)
    
    for i in 0..<3 {
        concurrentQueue.async {
            print("#block1 -> \(i) -> Waiting")
            semaphore.wait()
            print("#block1 -> \(i) -> Wait finished")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block1 -> \(i) -> \(data?.count)")
            semaphore.signal()
        }
    }
    
        //    for i in 3..<6 {
        //        concurrentQueue.async {
        //            print("Printing values from #block2 -> \(i) -> Start")
        //            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
        //            print("Printing values from #block2 -> \(i) -> \(data?.count)")
        //        }
        //    }
    
    for i in 6..<9 {
        concurrentQueue.async {
            print("#block3 -> \(i) -> Waiting")
            semaphore.wait()
            print("#block3 -> \(i) -> Wait finished")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
            semaphore.signal()
        }
    }
}
executeFuncWithSemaphoreMultipleExecutions()
