//: [Previous](@previous)

import Foundation
//MARK: Q1 1. Two Sum - Easy
///Given an array of integers nums and an integer target , return indices of the two numbers such that they add up to target
///You may assume that each input would have exactly one solution, and you may not use the same element twice.
///You can return the answer in any order.

func twoSumUnSorted(array: [Int], sum: Int) -> (firstNumber: Int, secondNumber: Int)? {
    var sumDict: [Int:Int] = [:]
    
    for item in array {
        if let result = sumDict[item] {
            return (result, item)
        }
        
        let remaining = sum - item
        sumDict[remaining] = item
    }
    
    return nil
}
//let result = twoSumUnSorted(array: [1,2,3,4,5,6,7,8,9], sum: 13)
//print("Result is \(result!)")

//MARK: Q2 167. Two Sum II - Input Array Is Sorted
///Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number.
///Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 < numbers.length.
///Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.
///The tests are generated such that there is exactly one solution. You may not use the same element twice.
///Your solution must use only constant extra space.
func twoSumSorted(array: [Int], sum: Int) -> (firstNumber: Int, secondNumber: Int)? {
    var firstIndex = 0
    var lastIndex = array.count - 1
    
    while firstIndex < lastIndex {
        let result = array[firstIndex] + array[lastIndex]
        if result == sum {
            return (array[firstIndex], array[lastIndex])
        } else if result > sum {
            lastIndex -= 1
        } else {
            firstIndex += 1
        }
    }
    
    return nil
}

//let result = twoSumSorted(array: [1,2,3,4,5,6,7,8,9], sum: 13)
//print("Result is \(result!)")

//: [Next](@next)


//MARK: Q3 20. Valid Parentheses
///Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
///An input string is valid if:
///Open brackets must be closed by the same type of brackets.
///Open brackets must be closed in the correct order
///Every close bracket has a corresponding open bracket of the same type.


func checkValidParenthesis(in str: String) -> Bool {
    
    var currentBracketStack: [Character] = []
    var charachters: [Character : Character] = ["}" : "{", "]" : "[", ")" : "("]
    
    for charachter in str {
        if charachter == "(" || charachter == "{" || charachter == "[" {
            currentBracketStack.append(charachter)
        } else if currentBracketStack.count > 0 {
            let char = currentBracketStack[currentBracketStack.count - 1]
            if let topCharachter = charachters[charachter], topCharachter == char {
                currentBracketStack.removeLast()
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    if currentBracketStack.count == 0 {
        return true
    }
    
    return false
}

//let s = ")"
//let result = checkValidParenthesis(in: s)
//print("Result is \(result)")


//MARK: Q4 121. Best Time to Buy and Sell Stock
///You are given an array prices where prices[i] is the price of a given stock on the ith day.
///You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.
///Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.
///
///Input: prices = [7,1,5,3,6,4]
///Output: 5
///Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
///Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
///
///Input: prices = [7,6,4,3,1]
///Output: 0
///Explanation: In this case, no transactions are done and the max profit = 0.
func stockPriceBruteForce(forDay daysArray: [Int]) -> Int {
    var max = 0
    for i in 0 ..< daysArray.count - 1 {
        for j in i ..< daysArray.count {
            if daysArray[j] > daysArray[i] {
                let result = daysArray[j] - daysArray[i]
                if max < result {
                    max = result
                }
            }
        }
    }
    return max
}

//let result = stockPriceBruteForce(forDay: [7,1,5,3,6,4])
//print("Result is \(result)")


func stockPriceTwoPointer(forDay dayPrices: [Int]) -> Int {
    var buyPrice = Int.max
    var sellPrice = Int.min
    var profit = 0
    
    for price in dayPrices {
        if buyPrice > price {
            buyPrice = price
            sellPrice = price
        } else if sellPrice < price {
            sellPrice = price
        }
        
        let newProfit = sellPrice - buyPrice
        if profit < newProfit {
            profit = newProfit
        }
    }
    
    return profit
}
//let result = stockPriceTwoPointer(forDay: [7,1,5,3,6,4])
//print("Result is \(result)")



//Pending solution
//22. Generate Parentheses
///Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
///Input: n = 3
///Output: ["((()))","(()())","(())()","()(())","()()()"]
func generateParantheses(level count: Int) -> [String] {
    var parenthesesArray: [Character] = Array(repeating: "(", count: count)
    parenthesesArray.append(contentsOf: Array(repeating: ")", count: count))
    var startIndex = count - 1
    
    var allCombinations: Set<String> = Set()
    allCombinations.insert(String(parenthesesArray))
    
    var shiftRightArray = parenthesesArray
    while startIndex > 0 {
        var shift = 0
        var internalStartIndex = startIndex
//        print("Loop1-InternalStartIndex \(internalStartIndex)")
        while shift < count - (count - startIndex) {
            let charchter = shiftRightArray.remove(at: internalStartIndex)
            internalStartIndex += 1
            shiftRightArray.insert(charchter, at: internalStartIndex)
            shift += 1
            allCombinations.insert(String(shiftRightArray))
        }
        
//        print("Loop1-AllCombination \(allCombinations)")
        startIndex -= 1
    }
    
    var shiftLeft = parenthesesArray
    startIndex = count
    while startIndex < parenthesesArray.count - 1 {
        var shift = 0
        var internalStartIndex = startIndex
//        print("Loop2-InternalStartIndex \(internalStartIndex)")
        while shift < (parenthesesArray.count - 1) - startIndex {
            let charchter = shiftLeft.remove(at: internalStartIndex)
            internalStartIndex -= 1
            shiftLeft.insert(charchter, at: internalStartIndex)
            shift += 1
            allCombinations.insert(String(shiftLeft))
        }
//        print("Loop2-AllCombination \(allCombinations)")
        startIndex += 1
    }
    
//    print("Full AllCombination \(allCombinations)")
    return Array(allCombinations)
}
//let result = generateParantheses(level: 4)
//print("Result -> \(result)")

func generateParenthesesCombinations(arr: inout [String], str: String, openCount: Int, closeCount: Int) {
    if closeCount == 0 && openCount == 0 {
        print("CurrentString is \(str), current array is \(arr)")
        arr.append(str)
        return
    }
    
    if closeCount > 0 {
//        print("Calling ) this \(str + ")") openCount - \(openCount) close count \(closeCount - 1)")
        generateParenthesesCombinations(arr: &arr, str: str + ")", openCount: openCount, closeCount: closeCount - 1)
        print("Down ) this \(str) openCount - \(openCount) close count \(closeCount)")
    }
    
    if openCount > 0 {
//        print("Calling ( this \(str + "(") openCount - \(openCount - 1) close count \(closeCount + 1)")
        generateParenthesesCombinations(arr: &arr, str: str + "(", openCount: openCount - 1, closeCount: closeCount + 1)
        print("Down ( this \(str) openCount - \(openCount) close count \(closeCount)")
    }
}

func generateParenthesesNewAttempt(_ n: Int) -> [String] {
    var arr: [String] = []
    generateParenthesesCombinations(arr: &arr, str: "", openCount: n, closeCount: 0)
    print("Array \(arr)")
    return arr
}
generateParenthesesNewAttempt(3)

//MARK: Q5 169. Majority Element
///Given an array nums of size n, return the majority element.
///The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.
///
///Input: nums = [3,2,3]
///Output: 3
///
///Input: nums = [2,2,1,1,1,2,2]
///Output: 2
func majorityElement(_ nums: [Int]) -> Int {
    
    var majority: [Int : Int] = [:]
    for num in nums {
        if let _ = majority[num] {
            majority[num]! += 1
        } else {
            majority[num] = 1
        }
    }
    
    var currentNum = 0
    var max = Int.min
    for (key, value) in majority {
//        print("Value is \(value), key is \(key)")
        if value > max {
            max = value
            currentNum = key
        }
    }
    
    return currentNum
}
//let result = majorityElement([2,2,1,1,1,2,2])
//print("Result is \(result)")


func majorityElementInPlace(_ nums: [Int]) -> Int {
    var maxNumber = Int.min
    var maxCount = Int.min
    var currentCount = Int.min
    var currentNumber = Int.min
    
    for num in nums.sorted() {
        if num != currentNumber {
            currentCount = 1
            currentNumber = num
        } else {
            currentCount += 1
        }
        
        if maxCount < currentCount {
            maxCount = currentCount
            maxNumber = currentNumber
        }
    }
    
    return maxNumber
}
//let result = majorityElementInPlace([2,2,1,1,1,2,2])
//print("Result is \(result)")


//MARK: Q6 283. Move Zeroes
///Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
///Note that you must do this in-place without making a copy of the array.
///
///Input: nums = [0,1,0,3,12]
///Output: [1,3,12,0,0]
func moveZeroes(_ nums: inout [Int]) {
    var count = nums.count - 1
    var index = 0
    while index <= count {
        if nums[index] == 0 {
            nums.append(nums.remove(at: index))
            count -= 1
            continue
        }
        
        index += 1
    }
    
    print("Array is \(nums)")
}

//var array = [0,1,0,3,0,12]
//moveZeroes(&array)


//MARK: Q7 977. Squares of a Sorted Array
///Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.
///Input: nums = [-4,-1,0,3,10]
///Output: [0,1,9,16,100]
///Explanation: After squaring, the array becomes [16,1,0,9,100].
///After sorting, it becomes [0,1,9,16,100].
func sortedSquares(_ nums: [Int]) -> [Int] {
    var array = nums
    
    for index in 0..<array.count {
        array[index] = array[index] * array[index]
    }
    
    return array.sorted()
}
//let result = sortedSquares([-4,-1,0,3,10])
//print("Result is \(result)")


//MARK: Q8 88. Merge Sorted Array
///You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.
///Merge nums1 and nums2 into a single array sorted in non-decreasing order.
///The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.
///
///Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
///Output: [1,2,2,3,5,6]
///Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
///The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
///
///Input: nums1 = [1], m = 1, nums2 = [], n = 0
///Output: [1]
///Explanation: The arrays we are merging are [1] and [].
///The result of the merge is [1].
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var newNum = nums1
    var leftArrayIndex = 0
    var rightArrayIndex = 0
    var currentIndex = 0
    while leftArrayIndex < m && rightArrayIndex < n {
        if newNum[leftArrayIndex] < nums2[rightArrayIndex] {
            nums1[currentIndex] = newNum[leftArrayIndex]
            leftArrayIndex += 1
        } else {
            nums1[currentIndex] = nums2[rightArrayIndex]
            rightArrayIndex += 1
        }
        
        currentIndex += 1
    }
    
    while leftArrayIndex < m {
        nums1[currentIndex] = newNum[leftArrayIndex]
        leftArrayIndex += 1
        currentIndex += 1
    }
    
    while rightArrayIndex < n {
        nums1[currentIndex] = nums2[rightArrayIndex]
        rightArrayIndex += 1
        currentIndex += 1
    }
    
    print("Array \(nums1)")
}
var arr1 = [1,2,3,0,0,0]
//merge(&arr1, 3, [2,5,6], 3)

func mergeInPlace(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var index = 0
        for i in m ..< nums1.count {
            nums1[i] = nums2[index]
            index += 1
        }
    
    nums1 = nums1.sorted()
    print("nums1 -> \(nums1)")
}
//mergeInPlace(&arr1, 3, [2,5,6], 3)

func mergeInPlaceShorterApproach(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    nums1 = (nums1[..<m] + nums2).sorted()
    print("nums1 -> \(nums1)")
}
//mergeInPlaceShorterApproach(&arr1, 3, [2,5,6], 3)

