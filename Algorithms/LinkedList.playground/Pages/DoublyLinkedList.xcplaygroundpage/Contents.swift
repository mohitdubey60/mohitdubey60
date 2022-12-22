import Foundation

class Node {
    let value: Int
    var nextPointer: Node?
    var previousPointer: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class DoublyLinkedListManager {
    static let shared = DoublyLinkedListManager()
    private init() {}
    
    private var startNode: Node?
    private var endNode: Node?
    
    func addNewNode(value: Int) {
        if startNode == nil {
            let newNode = Node(value: value)
            startNode = newNode
            endNode = newNode
            return
        } else if startNode!.value >= value {
            let newNode = Node(value: value)
            newNode.nextPointer = startNode
            startNode?.previousPointer = newNode
            startNode = newNode
            return
        } else {
            if var node = startNode {
                while true {
                    if node.value < value, node.nextPointer == nil {
                        let newNode = Node(value: value)
                        node.nextPointer = newNode
                        newNode.previousPointer = node
                        endNode = newNode
                    } else if node.value < value && node.nextPointer!.value >= value {
                        let newNode = Node(value: value)
                        newNode.nextPointer = node.nextPointer
                        newNode.previousPointer = node
                        node.nextPointer!.previousPointer = newNode
                        node.nextPointer = newNode
                    }
                    
                    if node.nextPointer != nil {
                        node = node.nextPointer!
                    } else {
                        return
                    }
                }
            }
        }
    }
    
    func removeNode(value: Int) {
        if var node = startNode {
            while true {
                if node.value == value {
                    if node.previousPointer == nil {
                        startNode = node.nextPointer
                        
                        if node.nextPointer == nil {
                            endNode = startNode
                        }
                    } else if node.nextPointer == nil {
                        endNode = node.previousPointer
                        endNode?.nextPointer = nil
                    } else {
                        node.previousPointer?.nextPointer = node.nextPointer
                        node.nextPointer?.previousPointer = node.previousPointer
                    }
                }
                
                if node.nextPointer != nil {
                    node = node.nextPointer!
                } else {
                    return
                }
            }
        }
        
        print("Node not found")
    }
    
    func traverse() {
        var node = startNode
        while node != nil {
            print("Node is \(node!.value)")
            node = node?.nextPointer
        }
        
        print("_______________________________________")
    }
    
    func traverseReverse() {
        var node = endNode
        while node != nil {
            print("Node is \(node!.value)")
            node = node?.previousPointer
        }
        
        print("_______________________________________")
    }
}


DoublyLinkedListManager.shared.addNewNode(value: 1)
DoublyLinkedListManager.shared.addNewNode(value: 2)
DoublyLinkedListManager.shared.addNewNode(value: 1)
DoublyLinkedListManager.shared.addNewNode(value: 3)
DoublyLinkedListManager.shared.addNewNode(value: 2)
DoublyLinkedListManager.shared.addNewNode(value: 5)
DoublyLinkedListManager.shared.addNewNode(value: 4)
DoublyLinkedListManager.shared.addNewNode(value: 6)

DoublyLinkedListManager.shared.traverse()
DoublyLinkedListManager.shared.traverseReverse()

DoublyLinkedListManager.shared.removeNode(value: 2)
DoublyLinkedListManager.shared.traverse()
DoublyLinkedListManager.shared.traverseReverse()
