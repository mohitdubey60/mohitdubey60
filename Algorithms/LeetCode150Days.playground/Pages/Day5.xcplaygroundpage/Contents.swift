//: [Previous](@previous)

import Foundation

//MARK: - Q1 Reverse Linked List
///Given the head of a singly linked list, reverse the list, and return the reversed list.
///
///Input: head = [1,2,3,4,5]
///Output: [5,4,3,2,1]
///
///Input: head = [1,2]
///Output: [2,1]
public class ListNode {
    var val: Int = 0
    var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
}
class ReverseList {
    var head: ListNode?
    
    func generateLists(list nums: [Int]) -> ListNode? {
        var head: ListNode?
        var currentNode: ListNode?
        for num in nums {
            if head == nil {
                head = ListNode(num)
                head?.next = nil
                currentNode = head
            } else {
                let newNode = ListNode(num)
                newNode.next = nil
                currentNode?.next = newNode
                currentNode = newNode
            }
        }
        return head
    }
    func traverseList(list: ListNode) {
        var head: ListNode? = list
        while head != nil {
            print(head?.val)
            head = head?.next
        }
    }
    private func reverseList(node: ListNode?) -> ListNode? {
        var currentNode: ListNode? = node
        if currentNode?.next == nil {
            head = currentNode
            print(head?.val)
            return currentNode
        }
        
        let newNode = reverseList(node: currentNode?.next)
        newNode?.next = currentNode
        return currentNode
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        let node = reverseList(node: head)
        node?.next = nil
        return self.head
    }
    
    func reverseListUsingLoop(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var pointer = head?.next
        var prev = head
        prev?.next = nil
        
        while pointer != nil {
            var temp = pointer?.next
            pointer?.next = prev
            prev = pointer
            pointer = temp
        }
        
        
        
        return prev
    }
}
//let obj = ReverseList()
//if let head = obj.generateLists(list: [1,2,3,4,5]) {
//    obj.traverseList(list: head)
//    if let reverseHead = obj.reverseListUsingLoop(head) {
//        print(reverseHead.val)
//        obj.traverseList(list: reverseHead)
//    }
//}


//: [Next](@next)
//MARK: - Q2 203. Remove Linked List Elements
///Given the head of a linked list and an integer val, remove all the nodes of the linked list that has Node.val == val, and return the new head.
///Input: head = [1,2,6,3,4,5,6], val = 6
///Output: [1,2,3,4,5]


