import Foundation


class Node {
    let value: Int
    var pointer: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class QueueManager {
    private init(){}
    static let shared: QueueManager = QueueManager()
    
    private var startNode: Node?
    private var endNode: Node?
    
    func enqueue(value: Int) {
        let node = Node(value: value)
        if startNode == nil {
            startNode = node
            endNode = node
        } else {
            if var en = endNode {
                en.pointer = node
                endNode = node
            }
        }
    }
    
    func dequeue() -> Node? {
        if startNode != nil {
            let node = startNode
            startNode = startNode?.pointer
            return node
        }
        
        return nil
    }
    
    func traverse() {
        var node = startNode
        while node != nil {
            print("Value of node is \(node!.value)")
            node = node!.pointer
        }
        
        print("_____________________")
    }
}


QueueManager.shared.enqueue(value: 1)
QueueManager.shared.enqueue(value: 3)
QueueManager.shared.enqueue(value: 2)
QueueManager.shared.enqueue(value: 4)
QueueManager.shared.enqueue(value: 5)
QueueManager.shared.traverse()


QueueManager.shared.dequeue()
QueueManager.shared.traverse()
