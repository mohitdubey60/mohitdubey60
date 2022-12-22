import Foundation

var stack: [Int] = []
var top = 0
var max = 10

func push(element item: Int) {
    if top < max {
        if top == 0 {
            stack.insert(item, at: 0)
        } else {
            for index in stride(from: top, to: 0, by: -1) {
                if index == stack.count {
                    stack.append(stack[index - 1])
                } else {
                    stack[index] = stack[index - 1]
                }
            }
            
            stack[0] = item
        }
        
        top += 1
    }
    
    print("Items in stack are \(stack), top is \(top)")
}

func pop() -> Int {
    if top > 0 {
        let itemToRemove = stack.first
        for index in 0..<(top - 1) {
            stack[index] = stack[index + 1]
        }
        
        top -= 1
        stack.removeLast()
        return itemToRemove!
    }
                
    return -1
}

func traverse() {
    for item in stack {
        print("Item is \(item)")
    }
}

func topElement() -> Int {
    if stack.count > 0 {
        return stack.first!
    }
    
    return -1
}

push(element: 10)
push(element: 20)
push(element: 30)
push(element: 40)
push(element: 50)

traverse()
print("Top element is \(topElement())")

print("Removed item is \(pop())")
print("Removed item is \(pop())")

traverse()
print("Top element is \(topElement())")

