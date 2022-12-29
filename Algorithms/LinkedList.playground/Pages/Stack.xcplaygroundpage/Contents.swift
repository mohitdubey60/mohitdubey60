import Foundation

class Node {
    let value: Int
    var pointer: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class StackManager {
    private init(){}
    static let shared = StackManager()
    
    private var startNode: Node?
    private var endNode: Node?
    
    func push(value: Int) {
        let node = Node(value: value)
        if startNode == nil {
            startNode = node
            endNode = node
        } else {
            node.pointer = startNode
            startNode = node
        }
    }
    
    func pop() -> Node? {
        if let sn = startNode {
            startNode = startNode?.pointer
            return sn
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

StackManager.shared.push(value: 1)
StackManager.shared.push(value: 2)
StackManager.shared.push(value: 3)
StackManager.shared.push(value: 4)
StackManager.shared.push(value: 5)
StackManager.shared.traverse()

StackManager.shared.pop()
StackManager.shared.traverse()
