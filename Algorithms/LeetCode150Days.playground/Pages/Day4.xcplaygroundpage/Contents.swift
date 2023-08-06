//: [Previous](@previous)

import Foundation

//MARK: - Q1 1002. Find Common Characters
///Given a string array words, return an array of all characters that show up in all strings within the words (including duplicates). You may return the answer in any order.
///
///Input: words = ["bella","label","roller"]
///Output: ["e","l","l"]
///
///Input: words = ["cool","lock","cook"]
///Output: ["c","o"]
func commonChars(_ words: [String]) -> [String] {
    var firstWord = (words.first ?? "").reduce(into: [:], {$0[$1, default: 0] += 1})
    var availableKeys: [String] = []
    
    for word in words {
        let newWord = word.reduce(into: [:], {$0[$1, default: 0] += 1})
        
        for (letter, count) in firstWord {
            if let newLetterCount = newWord[letter] {
                firstWord[letter] = min(count, newLetterCount)
            } else {
                firstWord[letter] = nil
            }
        }
    }
    
    for (key, value) in firstWord {
        availableKeys.append(contentsOf: Array(repeating: "\(key)", count: value))
    }
    
    return availableKeys
}

//let result = commonChars(["bella","label","roller"])
//print("\(result)")
//: [Next](@next)

//: [Previous](@previous)
//MARK: - Q2 1588. Sum of All Odd Length Subarrays
///Given an array of positive integers arr, return the sum of all possible odd-length subarrays of arr.
///A subarray is a contiguous subsequence of the array.
///
///Input: arr = [1,4,2,5,3]
///Output: 58
///Explanation: The odd-length subarrays of arr and their sums are:
///[1] = 1
///[4] = 4
///[2] = 2
///[5] = 5
///[3] = 3
///[1,4,2] = 7
///[4,2,5] = 11
///[2,5,3] = 10
///[1,4,2,5,3] = 15
///If we add all these together we get 1 + 4 + 2 + 5 + 3 + 7 + 11 + 10 + 15 = 58
func sumOddLengthSubarrays(_ arr: [Int]) -> Int {
    var sum = 0
    let count = 1
    var indexArray: [Int] = []
    for i in stride(from: 1, to: arr.count + 1, by: 2) {
        indexArray.append(i)
    }
    
    for length in indexArray {
        for index in 0..<arr.count {
            if (index-1) + length >= arr.count {
                break
            }
            
            for i in index..<index + length {
                sum += arr[i]
            }
            
        }
    }
    
    return sum
}
//let result = sumOddLengthSubarrays([10,11,12])
//print("\(result)")
//: [Next](@next)

//MARK: - Q3 303. Range Sum Query - Immutable
///Given an integer array nums, handle multiple queries of the following type:
///Calculate the sum of the elements of nums between indices left and right inclusive where left <= right.
///Implement the NumArray class:
///NumArray(int[] nums) Initializes the object with the integer array nums.
///int sumRange(int left, int right) Returns the sum of the elements of nums between indices left and right inclusive (i.e. nums[left] + nums[left + 1] + ... + nums[right]).
///
///Input
///["NumArray", "sumRange", "sumRange", "sumRange"]
///[[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
///Output
///[null, 1, -1, -3]
///Explanation
///NumArray numArray = new NumArray([-2, 0, 3, -5, 2, -1]);
///numArray.sumRange(0, 2); // return (-2) + 0 + 3 = 1
///numArray.sumRange(2, 5); // return 3 + (-5) + 2 + (-1) = -1
///numArray.sumRange(0, 5); // return (-2) + 0 + 3 + (-5) + 2 + (-1) = -3
class NumArray {
    let nums: [Int]
    var sumArray: [Int]
    init(_ nums: [Int]) {
        self.nums = nums
        
        sumArray = Array(repeating: 0, count: nums.count)
        
        for (index, value) in nums.enumerated() {
            if index == 0 {
                sumArray[index] = value
            } else {
                sumArray[index] = sumArray[index - 1] + value
            }
        }
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
        if left >= 0, left < nums.count, left <= right, right < nums.count {
            return nums[left...right].reduce(0, +)
        }
        return 0
    }
    
    func sumRangeOptimised(_ left: Int, _ right: Int) -> Int {
        if left >= 0, left < nums.count, left <= right, right < nums.count {
            if left == right {
                return nums[left]
            }
            print(sumArray)
            let result = (sumArray[right] - sumArray[left]) + nums[left]
            return result
        }
        
        return 0
    }
}

//let obj = NumArray([-2, 0, 3, -5, 2, -1])
//let ret_1: Int = obj.sumRangeOptimised(2, 5)
//print(ret_1)


//MARK: - Q4 1470. Shuffle the Array
///Given the array nums consisting of 2n elements in the form [x1,x2,...,xn,y1,y2,...,yn].
///Return the array in the form [x1,y1,x2,y2,...,xn,yn].
///
///Input: nums = [2,5,1,3,4,7], n = 3
///Output: [2,3,5,4,1,7]
///Explanation: Since x1=2, x2=5, x3=1, y1=3, y2=4, y3=7 then the answer is [2,3,5,4,1,7].
///
///Input: nums = [1,2,3,4,4,3,2,1], n = 4
///Output: [1,4,2,3,3,2,4,1]
///
///Input: nums = [1,1,2,2], n = 2
///Output: [1,2,1,2]
func shuffle(_ nums: [Int], _ n: Int) -> [Int] {
    var leftPointer = 0
    var rightPointer = n
    var localNum: [Int] = []
    for i in 0..<n {
        localNum.append(nums[leftPointer])
        localNum.append(nums[rightPointer])
        
        leftPointer += 1
        rightPointer += 1
    }
    
    return localNum
}
//let result = shuffle([1,2,3,4,4,3,2,1], 4)
//print(result)


//MARK: - Q5 485. Max Consecutive Ones
///Given a binary array nums, return the maximum number of consecutive 1's in the array
///
///Input: nums = [1,1,0,1,1,1]
///Output: 3
///Explanation: The first two digits or the last three digits are consecutive 1s. The maximum number of consecutive 1s is 3.
///
///Input: nums = [1,0,1,1,0,1]
///Output: 2
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var maxCount = 0
    var currentCount = 0
    
    for num in nums {
        if num != 1 {
            maxCount = max(currentCount, maxCount)
            currentCount = 0
        } else {
            currentCount += 1
        }
    }
    
    maxCount = max(currentCount, maxCount)
    
    return maxCount
}
//let maxCount = findMaxConsecutiveOnes([1,0,1,1,0,1])
//print(maxCount)


//MARK: - Q6 905. Sort Array By Parity
///Given an integer array nums, move all the even integers at the beginning of the array followed by all the odd integers.
///Return any array that satisfies this condition.
///
///Input: nums = [3,1,2,4]
///Output: [2,4,3,1]
///Explanation: The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.
///
///Input: nums = [0]
///Output: [0]
func sortArrayByParity(_ nums: [Int]) -> [Int] {
    var leftPointer = 0
    var rightPointer = nums.count - 1
    var localNums = nums
    
    while leftPointer < rightPointer {
        
        if localNums[leftPointer] % 2 != 0 && localNums[rightPointer] % 2 == 0 {
            localNums[rightPointer] = localNums[leftPointer] + localNums[rightPointer]
            localNums[leftPointer] = localNums[rightPointer] - localNums[leftPointer]
            localNums[rightPointer] = localNums[rightPointer] - localNums[leftPointer]
        }
        
        if localNums[leftPointer] % 2 == 0 {
            leftPointer += 1
        }
        
        if localNums[rightPointer] % 2 != 0 {
            rightPointer -= 1
        }
    }
    
    return localNums
}
let result = sortArrayByParity([3,1,2,4])
print(result)
