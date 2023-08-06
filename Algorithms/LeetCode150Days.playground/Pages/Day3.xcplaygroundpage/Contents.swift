//: [Previous](@previous)

import Foundation
//MARK: - Q1 1480. Running Sum of 1d Array
///Given an array nums. We define a running sum of an array as runningSum[i] = sum(nums[0]…nums[i]).
///Return the running sum of nums.
///
///Input: nums = [1,2,3,4]
///Output: [1,3,6,10]
///Explanation: Running sum is obtained as follows: [1, 1+2, 1+2+3, 1+2+3+4].
func runningSum(of nums: [Int]) -> [Int] {
    var totalSum = nums.reduce(0, +)
    var currentSum = 0
    var runningSum: [Int] = []
    
    for num in nums {
        let result = totalSum - currentSum - num
        runningSum.append(totalSum - result)
        currentSum += num
    }
    
    return runningSum
}

func runningSumAnotherWay(of nums: [Int]) -> [Int] {
    var runningSum: [Int] = []
    if nums.count > 0 {
        runningSum.append(nums[0])
    }
    
    for index in 1..<nums.count {
        runningSum.append(nums[index] + runningSum[index - 1])
    }
    
    return runningSum
}

//let result = runningSumAnotherWay(of: [1,2,3,4])
//print("result \(result)")
//: [Next](@next)

//: [Previous](@previous)
//MARK: - Q2 27. Remove Element
///Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The order of the elements may be changed. Then return the number of elements in nums which are not equal to val.
///Consider the number of elements in nums which are not equal to val be k, to get accepted, you need to do the following things:
///Change the array nums such that the first k elements of nums contain the elements which are not equal to val. The remaining elements of nums are not important as well as the size of nums.
///Return k.
///
///Input: nums = [3,2,2,3], val = 3
///Output: 2, nums = [2,2,_,_]
///Explanation: Your function should return k = 2, with the first two elements of nums being 2.
///It does not matter what you leave beyond the returned k (hence they are underscores).
func removeElements_InPlaceReplace(_ nums: inout [Int], _ val: Int) -> Int {
    var slow = 0
    
    for k in 0..<nums.count {
        if nums[k] != val {
            nums[slow] = nums[k]
            slow += 1
        }
    }
    
    return slow
}
var array = [3,2,2,3]
//let result = removeElements_InPlaceReplace(&array, 3)
//print("Result is \(array.prefix(result))")

func removeElements_AnotherArray(_ nums: inout [Int], _ val: Int) -> Int {
    var array: [Int] = []
    
    for num in nums {
        if num != val {
            array.append(num)
        }
    }
    
    nums = array
    
    return array.count
}
//let result = removeElements_AnotherArray(&array, 3)
//print("Result is \(array.prefix(result))")
//: [Next](@next)

//: [Previous](@previous)
//MARK: Q3 - 1275. Find Winner on a Tic Tac Toe Game
///Tic-tac-toe is played by two players A and B on a 3 x 3 grid. The rules of Tic-Tac-Toe are:
///Players take turns placing characters into empty squares ' '.
///The first player A always places 'X' characters, while the second player B always places 'O' characters.
///'X' and 'O' characters are always placed into empty squares, never on filled ones.
///The game ends when there are three of the same (non-empty) character filling any row, column, or diagonal.
///The game also ends if all squares are non-empty.
///No more moves can be played if the game is over.
///Given a 2D integer array moves where moves[i] = [rowi, coli] indicates that the ith move will be played on grid[rowi][coli]. return the winner of the game if it exists (A or B). In case the game ends in a draw return "Draw". If there are still movements to play return "Pending".
///You can assume that moves is valid (i.e., it follows the rules of Tic-Tac-Toe), the grid is initially empty, and A will play first.
///
///Input: moves = [[0,0],[2,0],[1,1],[2,1],[2,2]]
///Output: "A"
///Explanation: A wins, they always play first.
///
///Input: moves = [[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]]
///Output: "B"
///Explanation: B wins.
///
///Input: moves = [[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]]
///Output: "Draw"
///Explanation: The game ends in a draw since there are no moves to make.
func ticTacToeResult(_ moves: [[Int]]) -> String {
    func isWinnerMoves(playerMoves moves: [String]) -> Bool {
        var winningMoves: [[String:Bool]] = [
            ["00":true,"11":true,"22": true],
            ["02":true,"11":true,"20": true],
            ["00":true,"01":true,"02": true],
            ["10":true,"11":true,"12": true],
            ["20":true,"21":true,"22": true],
            ["00":true,"10":true,"20": true],
            ["01":true,"11":true,"21": true],
            ["02":true,"12":true,"22": true]]
        for move in winningMoves {
            var totalExist = 0
            for playerMove in moves {
                if let _ = move[playerMove] {
                    totalExist += 1
                    
                    if totalExist == 3 {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    var firstPlayerMoves: [String] = []
    var secondPlayerMoves: [String] = []
    for (index, value) in moves.enumerated() {
        index % 2 == 0 ?
        firstPlayerMoves.append("\(value[0])\(value[1])") :
        secondPlayerMoves.append("\(value[0])\(value[1])")
    }
        
    if isWinnerMoves(playerMoves: firstPlayerMoves) {
        return "A"
    } else if isWinnerMoves(playerMoves: secondPlayerMoves) {
        return "B"
    } else if moves.count < 9 {
        return "Pending"
    } else {
        return "Draw"
    }
}

//let result = ticTacToeResult([[1,2],[2,1],[1,0],[0,0],[0,1],[2,0],[1,1]])
//print("Winner is \(result)")


//MARK: - Q4 1920. Build Array from Permutation
///Given a zero-based permutation nums (0-indexed), build an array ans of the same length where ans[i] = nums[nums[i]] for each 0 <= i < nums.length and return it.
///A zero-based permutation nums is an array of distinct integers from 0 to nums.length - 1 (inclusive).
///
///Input: nums = [0,2,1,5,3,4]
///Output: [0,1,2,4,5,3]
///Explanation: The array ans is built as follows:
///ans = [nums[nums[0]], nums[nums[1]], nums[nums[2]], nums[nums[3]], nums[nums[4]], nums[nums[5]]]
///= [nums[0], nums[2], nums[1], nums[5], nums[3], nums[4]]
///= [0,1,2,4,5,3]
func buildArray(_ nums: [Int]) -> [Int] {
    
    if let max = nums.max(), max >= nums.count {
        return []
    } else if let min = nums.min(), min < 0 {
        return []
    }
    
    var index = 0
    var newArray: [Int] = nums.map({_ in
        index += 1
        return nums[nums[index - 1]]
    })
    
    return newArray
}
//let result = buildArray([0,2,1,5,3,4])
//print("Array - \(result)")

//MARK: - Q5 414. Third Maximum Number

func thirdMax(_ nums: [Int]) -> Int {
    let uniqueNumberArray: [Int] = Array(Set(nums)).sorted()
    if uniqueNumberArray.count < 3, uniqueNumberArray.count > 0 {
        return nums.max()!
    }
    
    return uniqueNumberArray[uniqueNumberArray.count - 3]
}
//let result = thirdMax([0,2,1,5,3,4])
//print("Array - \(result)")


//MARK: - Q6 941. Valid Mountain Array
///Given an array of integers arr, return true if and only if it is a valid mountain array.
///Recall that arr is a mountain array if and only if:
///arr.length >= 3
///There exists some i with 0 < i < arr.length - 1 such that:
///arr[0] < arr[1] < ... < arr[i - 1] < arr[i]
///arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
func validMountainArray(_ arr: [Int]) -> Bool {
    var isGoingUp = true
    
    if arr.count < 3 {
        return false
    }
    
    for (index, value) in arr.enumerated() {
        if index + 1 <= arr.count - 1 {
            if isGoingUp {
                let result = arr[index + 1] - value
                if result == 0 {
                    return false
                }
                
                if result < 0, index != 0 {
                    isGoingUp = false
                } else if result < 0, index == 0 {
                    return false
                }
            } else {
                let result = value - arr[index + 1]
                if result <= 0 {
                    return false
                }
            }
        }
    }
    
    return isGoingUp ? false : true
}
//let result = validMountainArray([3,5,5])
//print("Array - \(result)")


//MARK: - Q7 21. Merge Two Sorted Lists
///You are given the heads of two sorted linked lists list1 and list2.
///Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.
///Return the head of the merged linked list.
///
public class ListNode {
    var val: Int = 0
    var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
}
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
    print(head?.next)
    return head
}

func traverseList(list: ListNode) {
    var head: ListNode? = list
    while head != nil {
        print(head?.val)
        head = head?.next
    }
}

func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    var firstListNode = list1
    var secondListNode = list2
    
    var newList: ListNode?
    var newListHead: ListNode?
    
    func addToList(list: ListNode) {
        print("List -> \(list.val) \(list.next)")
        if newList == nil {
            newList = list
            newListHead = newList
        } else {
            newList?.next = list
            newList = list
        }
    }
    
    while firstListNode != nil && secondListNode != nil {
        if firstListNode!.val < secondListNode!.val {
            print("If \(firstListNode) \(secondListNode)")
            addToList(list: firstListNode!)
            firstListNode = firstListNode?.next
        } else {
            print("Else \(firstListNode) \(secondListNode)")
            addToList(list: secondListNode!)
            secondListNode = secondListNode?.next
        }
    }
    
    while firstListNode != nil {
        addToList(list: firstListNode!)
        firstListNode = firstListNode?.next
    }
    
    while secondListNode != nil {
        print("Second list -> \(secondListNode?.next)")
        addToList(list: secondListNode!)
        secondListNode = secondListNode?.next
    }
    
    return newListHead
}

let list1 = generateLists(list: [])
let list2 = generateLists(list: [0])

if let head = mergeTwoLists(list1, list2) {
    traverseList(list: head)
}
