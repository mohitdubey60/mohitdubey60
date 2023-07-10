    //: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


    ///Custom Queue made from GCD DispatchQueue API
    ///We can give it any name in the label property
    ///qos -> User-interactive, User-initiated, Default, Utility, Background, Unspecified
    ///attributes -> concurrent, initiallyInactive
    ///autoreleaseFrequency -> inherit, workItem, never

/*
 Output may change
 
 Execution start
 Printing values from #block2 -> 0 -> Start
 Printing values from #block2 -> 1 -> Start
 Printing values from #block1 -> 3 -> Start
 Printing values from #block2 -> 2 -> Start
 Printing values from #block2 -> 0 -> Optional(11351)
 Printing values from #block1 -> 3 -> Optional(17306)
 Printing values from #block1 -> 4 -> Start
 Printing values from #block2 -> 1 -> Optional(5656)
 Printing values from #block2 -> 2 -> Optional(13502)
 Printing values from #block1 -> 4 -> Optional(8436)
 Printing values from #block1 -> 5 -> Start
 Printing values from #block1 -> 5 -> Optional(8929)
 Execution end
 Printing values from #block3 -> 6 -> Start
 Printing values from #block3 -> 7 -> Start
 Printing values from #block3 -> 8 -> Start
 Printing values from #block3 -> 8 -> Optional(11389)
 Printing values from #block3 -> 7 -> Optional(9218)
 Printing values from #block3 -> 6 -> Optional(6133)
 */
func executeConcurrentQueueWithHeavyTask() {
    let concurrentQueue = DispatchQueue(label: "com.dispatchqueue.concurrentqueue", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit)
        //#Block1
    print("Execution start")
    
        //#Block2
    for i in 0..<3 {
        concurrentQueue.async {
            print("Printing values from #block2 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block2 -> \(i) -> \(data?.count)")
        }
    }
    
        //This is executing in block1
    for i in 3..<6 {
        print("Printing values from #block1 -> \(i) -> Start")
        let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
        print("Printing values from #block1 -> \(i) -> \(data?.count)")
    }
    
        //#Block3
    for i in 6..<9 {
        concurrentQueue.async {
            print("Printing values from #block3 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
        }
    }
    
        //#Block1
    print("Execution end")
}
//executeConcurrentQueueWithHeavyTask()

//Using Barrier
///If the queue is a serial queue or one of the global concurrent queues, the barrier would not work.
///Using barriers in a custom concurrent queue is a good choice for handling thread safety in critical areas of code.
/*
Expected output
 
 Execution start
 Execution end
 Printing values from #block2 -> 0 -> Start
 Printing values from #block2 -> 0 -> Optional(8976)
 Printing values from #block2 -> 1 -> Start
 Printing values from #block2 -> 1 -> Optional(16762)
 Printing values from #block2 -> 2 -> Start
 Printing values from #block2 -> 2 -> Optional(11045)
 Printing values from #block1 -> 3 -> Start
 Printing values from #block1 -> 4 -> Start
 Printing values from #block1 -> 5 -> Start
 Printing values from #block1 -> 3 -> Optional(14638)
 Printing values from #block1 -> 5 -> Optional(5897)
 Printing values from #block1 -> 4 -> Optional(10190)
 Printing values from #block3 -> 6 -> Start
 Printing values from #block3 -> 6 -> Optional(7376)
 Printing values from #block3 -> 7 -> Start
 Printing values from #block3 -> 7 -> Optional(12570)
 Printing values from #block3 -> 8 -> Start
 Printing values from #block3 -> 8 -> Optional(11742)
*/
func executeConcurrentThreadsWithBarrier() {
    let concurrentQueue = DispatchQueue(label: "com.dispatchqueue.concurrentqueue", qos: .background, attributes: [.concurrent], autoreleaseFrequency: .inherit)
        //#Block1
    print("Execution start")
    
        //#Block2
    for i in 0..<3 {
        concurrentQueue.async(flags: .barrier) {
            print("Printing values from #block2 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block2 -> \(i) -> \(data?.count)")
        }
    }
    
        //This is executing in block1
    for i in 3..<6 {
        concurrentQueue.async {
            print("Printing values from #block1 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block1 -> \(i) -> \(data?.count)")
        }
    }
    
        //#Block3
    for i in 6..<9 {
        concurrentQueue.async(flags: .barrier) {
            print("Printing values from #block3 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
        }
    }
    
        //#Block1
    print("Execution end")
}
executeConcurrentThreadsWithBarrier()
