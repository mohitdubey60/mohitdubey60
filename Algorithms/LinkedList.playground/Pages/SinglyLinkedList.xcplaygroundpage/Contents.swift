import Foundation

class Node {
    let value: Int
    var pointer: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class SinglyLinkedList {
    static let shared: SinglyLinkedList = SinglyLinkedList()
    
    private var startNode: Node?
    private var endNode: Node?
    
    private init() {}
    
    //Logic to add nodes in ascending order
    func addNewNode(value: Int) {
        if startNode == nil {
            startNode = Node(value: value)
            endNode = startNode
        } else if var node = startNode {
            if value <= node.value {
                let newNode = Node(value: value)
                newNode.pointer = node
                startNode = newNode
                return
            }
            
            while true {
                if value >= node.value {
                    if node.pointer == nil {
                        let newNode = Node(value: value)
                        node.pointer = newNode
                        endNode = newNode
                        return
                    } else if node.pointer!.value >= value {
                        let newNode = Node(value: value)
                        newNode.pointer = node.pointer
                        node.pointer = newNode
                        return
                    }
                }
                
                if node.pointer != nil {
                    node = node.pointer!
                } else {
                    return
                }
            }
        }
    }
    
    func remove(value: Int) {
        if var node = startNode {
            while true {
                if startNode != nil, startNode!.value == value, startNode!.pointer != nil {
                    node = startNode!.pointer!
                    startNode = node
                    continue
                }
                
                if node.pointer != nil, node.pointer!.value == value {
                    node.pointer = node.pointer!.pointer
                    if node.pointer == nil {
                        endNode = node
                    }
                    continue
                }
                
                if node.pointer != nil {
                    node = node.pointer!
                } else {
                    return
                }
            }
        }
    }
    
    func countOccurences(value: Int) -> Int {
        var count = 0
        var node = startNode
        while node != nil {
            if node!.value == value {
                count += 1
            }
            
            node = node?.pointer
        }
        
        return count
    }
    
    func traverse() {
        var node = startNode
        while node != nil {
            print("Node is \(node!.value)")
            node = node?.pointer
        }
        
        print("_____________________")
    }
}

SinglyLinkedList.shared.addNewNode(value: 1)
SinglyLinkedList.shared.addNewNode(value: 1)
SinglyLinkedList.shared.addNewNode(value: 2)
SinglyLinkedList.shared.addNewNode(value: 3)
SinglyLinkedList.shared.addNewNode(value: 2)
SinglyLinkedList.shared.addNewNode(value: 3)
SinglyLinkedList.shared.addNewNode(value: 4)
SinglyLinkedList.shared.addNewNode(value: 5)
SinglyLinkedList.shared.traverse()

SinglyLinkedList.shared.remove(value: 11)
SinglyLinkedList.shared.traverse()

let occurances = SinglyLinkedList.shared.countOccurences(value: 4)
print("Occurances is \(occurances)")
