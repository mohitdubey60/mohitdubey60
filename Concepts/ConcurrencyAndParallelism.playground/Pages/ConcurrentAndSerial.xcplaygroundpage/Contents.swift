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

    ///Main is always serial queue, it means that it will always use only one thread
    ///We should never call dispatch sync from the same thread for the same thread as it will result in deadlock
/*
 Grand Central Dispatch (GCD) is a queue based API that allows to execute closures
 on workers pools in the First-in First-out order. The completion order will
 depend on the duration of each job.
 
 A dispatch queue executes tasks either serially or concurrently
 but always in a FIFO order.
 
 Attempting to synchronously execute a work item on the main queue results in dead-lock.
 Do not call the dispatch_sync function from a task that is executing on the
 same queue that you pass to your function call. Doing so will deadlock the queue.
 If you need to dispatch to the current queue, do so asynchronously using the dispatch_async function.
 */

/*
 Expected output:
 Execution start
 Printing values from #block1 -> 3
 Printing values from #block1 -> 4
 Printing values from #block1 -> 5
 Execution end
 Printing values from #block2 -> 0
 Printing values from #block2 -> 1
 Printing values from #block2 -> 2
 Printing values from #block3 -> 6
 Printing values from #block3 -> 7
 Printing values from #block3 -> 8
 */
func executeBlocksOnMainThreadAsynchronously() {
        //#Block1
    print("Execution start")
    
        //Main is always a serial queue
        //#Block2
    DispatchQueue.main.async {
        for i in 0..<3 {
            print("Printing values from #block2 -> \(i)")
        }
    }
    
        //This is executing in block1
    for i in 3..<6 {
        print("Printing values from #block1 -> \(i)")
    }
    
        //#Block3
    DispatchQueue.main.async {
        for i in 6..<9 {
            print("Printing values from #block3 -> \(i)")
        }
    }
    
        //#Block1
    print("Execution end")
    
}
    //executeBlocksOnMainThreadAsynchronously()



    //Using concurrent queue - non-main thread queue
    //When we call sync thread then block will execute immediately
    //They are concurrent by default

/*
 Expected output
 Execution start
 Printing values from #block2 -> 0 -> Start
 Printing values from #block2 -> 0
 Printing values from #block2 -> 1 -> Start
 Printing values from #block2 -> 1
 Printing values from #block2 -> 2 -> Start
 Printing values from #block2 -> 2
 Printing values from #block1 -> 3 -> Start
 Printing values from #block1 -> 3
 Printing values from #block1 -> 4 -> Start
 Printing values from #block1 -> 4
 Printing values from #block1 -> 5 -> Start
 Printing values from #block1 -> 5
 Printing values from #block3 -> 6 -> Start
 Printing values from #block3 -> 6
 Printing values from #block3 -> 7 -> Start
 Printing values from #block3 -> 7
 Printing values from #block3 -> 8 -> Start
 Printing values from #block3 -> 8
 Execution end*/
func executeBlocksOnGlobalThreadSynchronous() {
        //#Block1
    print("Execution start")
    
        //#Block2
    DispatchQueue.global(qos: .default).sync {
        for i in 0..<3 {
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
    DispatchQueue.global(qos: .default).sync {
        for i in 6..<9 {
            print("Printing values from #block3 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
        }
    }
    
        //#Block1
    print("Execution end")
}
    //executeBlocksOnGlobalThreadSynchronous()


/*
 Result could vary
 Execution start
 Printing values from #block1 -> 3 -> Start
 Printing values from #block2 -> 2 -> Start
 Printing values from #block2 -> 1 -> Start
 Printing values from #block2 -> 0 -> Start
 Printing values from #block2 -> 0 -> Optional(11577)
 Printing values from #block2 -> 2 -> Optional(7315)
 Printing values from #block2 -> 1 -> Optional(11110)
 Printing values from #block1 -> 3 -> Optional(12345)
 Printing values from #block1 -> 4 -> Start
 Printing values from #block1 -> 4 -> Optional(7534)
 Printing values from #block1 -> 5 -> Start
 Printing values from #block1 -> 5 -> Optional(15961)
 Execution end
 Printing values from #block3 -> 8 -> Start
 Printing values from #block3 -> 6 -> Start
 Printing values from #block3 -> 7 -> Start
 Printing values from #block3 -> 6 -> Optional(12155)
 Printing values from #block3 -> 7 -> Optional(4012)
 Printing values from #block3 -> 8 -> Optional(8401)
 */
func executeBlocksOnGlobalThreadAsynchronous() {
        //#Block1
    print("Execution start")
    
        //#Block2
    for i in 0..<3 {
        DispatchQueue.global(qos: .default).async {
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
        DispatchQueue.global(qos: .default).async {
            print("Printing values from #block3 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
        }
    }
    
        //#Block1
    print("Execution end")
}
    //executeBlocksOnGlobalThreadAsynchronous()


/*
 Expected output
 
 Execution start
 Printing values from #block2 -> 0 -> Start
 Printing values from #block2 -> 0 -> Optional(6989)
 Printing values from #block2 -> 1 -> Start
 Printing values from #block2 -> 1 -> Optional(5383)
 Printing values from #block2 -> 2 -> Start
 Printing values from #block2 -> 2 -> Optional(8593)
 Printing values from #block1 -> 3 -> Start
 Printing values from #block1 -> 3 -> Optional(5854)
 Printing values from #block1 -> 4 -> Start
 Printing values from #block1 -> 4 -> Optional(9598)
 Printing values from #block1 -> 5 -> Start
 Printing values from #block1 -> 5 -> Optional(4013)
 Printing values from #block3 -> 6 -> Start
 Printing values from #block3 -> 6 -> Optional(7296)
 Printing values from #block3 -> 7 -> Start
 Printing values from #block3 -> 7 -> Optional(13549)
 Printing values from #block3 -> 8 -> Start
 Printing values from #block3 -> 8 -> Optional(7595)
 Execution end
 */
func executeSerialQueueWithHeavyTask() {
    let serialQueue = DispatchQueue(label: "com.dispatchqueue.serialqueue")
        //#Block1
    print("Execution start")
    
        //#Block2
    for i in 0..<3 {
        serialQueue.sync {
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
        serialQueue.sync {
            print("Printing values from #block3 -> \(i) -> Start")
            let data = try? Data(contentsOf: URL(string: "https://picsum.photos/200/300")!)
            print("Printing values from #block3 -> \(i) -> \(data?.count)")
        }
    }
    
        //#Block1
    print("Execution end")
}
executeSerialQueueWithHeavyTask()
