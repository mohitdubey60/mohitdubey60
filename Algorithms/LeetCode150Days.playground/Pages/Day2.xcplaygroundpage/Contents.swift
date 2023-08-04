//: [Previous](@previous)

import Foundation

//MARK: - Q1 26. Remove Duplicates from Sorted Array
///Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same. Then return the number of unique elements in nums.
///Consider the number of unique elements of nums to be k, to get accepted, you need to do the following things:
///Change the array nums such that the first k elements of nums contain the unique elements in the order they were present in nums initially. The remaining elements of nums are not important as well as the size of nums.
///Return k.
///Custom Judge:
///
///Input: nums = [0,0,1,1,1,2,2,3,3,4]
///Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
///Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
///It does not matter what you leave beyond the returned k (hence they are underscores).
func removeDuplicateNumbersFromSortedArray(_ nums: inout [Int]) -> Int {
    var i = 0
    while i < nums.count {
        if i+1 < nums.count, nums[i] == nums[i+1] {
            nums.remove(at: i+1)
            continue
        }
        
        i += 1
    }
    
    return nums.count
}
//var array = [0,0,1,1,1,2,2,3,3,4]
//let result = removeDuplicateNumbersFromSortedArray(&array)
//print("Count is \(result), array is \(array)")
//: [Next](@next)

func removeDuplicateNumbersFromSortedArrayUsingSet(_ nums: inout [Int]) -> Int {
    var numberSet = Set<Int>()
    for num in nums {
        numberSet.insert(num)
    }
    
    nums = Array(numberSet).sorted()
    
    return nums.count
}


//MARK: - Q2 80. Remove Duplicates from Sorted Array II
///Given an integer array nums sorted in non-decreasing order, remove some duplicates in-place such that each unique element appears at most twice.
///The relative order of the elements should be kept the same.Since it is impossible to change the length of the array in some languages,
///you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result.
///It does not matter what you leave beyond the first k elements.
///Return k after placing the final result in the first k slots of nums.
///Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
///
///Input: nums = [1,1,1,2,2,3]Output: 5, nums = [1,1,2,2,3,_]
///Explanation: Your function should return k = 5, with the first five elements of nums being 1, 1, 2, 2 and 3 respectively.
///It does not matter what you leave beyond the returned k (hence they are underscores).
///
///Input: nums = [0,0,1,1,1,1,2,3,3]
///Output: 7, nums = [0,0,1,1,2,3,3,_,_]
///Explanation: Your function should return k = 7, with the first seven elements of nums being 0, 0, 1, 1, 2, 3 and 3 respectively.
///It does not matter what you leave beyond the returned k (hence they are underscores).
func removeDuplicatesFromSortedArrayII(_ nums: inout [Int], allowedFrequency: Int = 1) -> Int {
    var fastPointer = 1
    var slowPointer = 0
    var currentItemCount = 1
    var currentItem = 0
    
    while fastPointer < nums.count {
        if nums[fastPointer] == nums[slowPointer] {
            currentItemCount += 1
            if currentItemCount < allowedFrequency + 1 {
                slowPointer += 1
                nums[slowPointer] = nums[fastPointer]
            }
        } else {
            slowPointer += 1
            nums[slowPointer] = nums[fastPointer]
            currentItemCount = 1
        }
        
        fastPointer += 1
    }
    
    return slowPointer + 1
}
//var array = [1,1,1,2,2,3]
//let result = removeDuplicatesFromSortedArrayII(&array, allowedFrequency: 2)
//print("Count is \(result), array is \(array)")


//MARK: - Q3 448. Find All Numbers Disappeared in an Array
///Given an array nums of n integers where nums[i] is in the range [1, n], return an array of all the integers in the range [1, n] that do not appear in nums.
///
///Input: nums = [4,3,2,7,8,2,3,1]
///Output: [5,6]
func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
    var array = 1...nums.count
    var disappearedArray: [Int] = []
    for num in array {
        if !nums.contains(num) {
            disappearedArray.append(num)
        }
    }
    
    return disappearedArray
}
//let result = findDisappearedNumbers([1,1,1,2,2,2])
//print(result)

func findDisappearingNumbersUsingCounterArray(_ nums: [Int]) -> [Int] {
    var disappearingNumberArray: [Int] = []
    var counterArray: [Int] = Array(repeating: 0, count: nums.count + 1)
    
    for num in nums {
        counterArray[num] = num
    }
    
    for i in stride(from: 1, to: counterArray.count, by: 1) {
        if counterArray[i] == 0 {
            disappearingNumberArray.append(i)
        }
    }
    
    return disappearingNumberArray
}
//let result = findDisappearingNumbersUsingCounterArray([1,1,1,2,2,2])
//print(result)


//MARK: - Q4  349. Intersection of Two Arrays
///Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must be unique and you may return the result in any order.
///
///Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
///Output: [9,4]
///Explanation: [4,9] is also accepted.
func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var intersection: Set<Int> = Set()
    var dict:[Int:Int] = [:]
    for num in nums1 {
        dict[num] = num
    }
    
    for num in nums2 {
        if let _ = dict[num] {
            intersection.insert(num)
        }
    }
    
    return Array(intersection)
}


//MARK: - Q5 350. Intersection of Two Arrays II
///Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.
///
///Input: nums1 = [1,2,2,1], nums2 = [2,2]
///Output: [2,2]
///
///Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
///Output: [4,9]
///Explanation: [9,4] is also accepted.
func intersectionWithFrequency(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var num1Dict: [Int:Int] = [:]
    var num2Dict: [Int:Int] = [:]
    var intersection: [Int] = []
    
    for num in nums1 {
        if let _ = num1Dict[num] {
            num1Dict[num]! += 1
        } else {
            num1Dict[num] = 1
        }
    }
    
    for num in nums2 {
        if let _ = num2Dict[num] {
            num2Dict[num]! += 1
        } else {
            num2Dict[num] = 1
        }
    }
    
    for key in num1Dict.keys {
        if let _ = num2Dict[key] {
            let result = min(num1Dict[key]!, num2Dict[key]!)
            
            intersection.append(contentsOf: Array(repeating: key, count: result))
        }
    }
    
    return intersection
}

func intersectionWithFrequencyUsingSingleDictionary(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var intersection: [Int] = []
    var map: [Int : Int] = [:]
    
    for num in nums1 {
        if let _ = map[num] {
            map[num]! += 1
        } else {
            map[num] = 1
        }
    }
    
    for num in nums2 {
        if let count = map[num], count > 0 {
            intersection.append(num)
            map[num] = count - 1
        }
    }
    
    return intersection
}
//let result = intersectionWithFrequencyUsingSingleDictionary([4,9,5], [9,4,9,8,4])
//print(result)


//MARK: - Q6 1854. Maximum Population Year
///You are given a 2D integer array logs where each logs[i] = [birthi, deathi] indicates the birth and death years of the ith person.
///The population of some year x is the number of people alive during that year. The ith person is counted in year x's population if x is in the inclusive range [birthi, deathi - 1]. Note that the person is not counted in the year that they die.
///Return the earliest year with the maximum population.
func maxPopulationYear(_ logs: [[Int]]) -> Int {
    var birthYears: Set<Int> = Set(logs.map({ $0[0] }))
    var populationByBirthYear: [Int: Int] = [:]
    let populationSortedLogs = logs.sorted(by: { $0[0] < $1[0] })
     
    for i in populationSortedLogs[0][0]...populationSortedLogs[populationSortedLogs.count - 1][1] {
        for person in populationSortedLogs {
            if i>=person[0] && i<person[1] {
                if let count = populationByBirthYear[i] {
                    populationByBirthYear[i] = count + 1
                } else {
                    populationByBirthYear[i] = 1
                }
            }
        }
    }
    
    var maxPopulationYear = 0
    var maxPopulation = 0
    
    for year in birthYears.sorted() {
        if let population = populationByBirthYear[year], population > maxPopulation {
            maxPopulation = population
            maxPopulationYear = year
        }
    }
    
//    for year in populationByBirthYear.keys.sorted() {
//        if populationByBirthYear[year]! > maxPopulation {
//            maxPopulation = populationByBirthYear[year]!
//            maxPopulationYear = year
//        }
//    }
    
    print("Max population year is \(maxPopulationYear) with population \(maxPopulation)")
    return maxPopulationYear
}
//let result = maxPopulationYear([[1950,1961],[1960,1971],[1970,1981]])
//print("Result is \(result)")

//MARK: - Q7 724. Find Pivot Index
///Given an array of integers nums, calculate the pivot index of this array.
///The pivot index is the index where the sum of all the numbers strictly to the left of the index is equal to the sum of all the numbers strictly to the index's right.
///If the index is on the left edge of the array, then the left sum is 0 because there are no elements to the left. This also applies to the right edge of the array.
///Return the leftmost pivot index. If no such index exists, return -1.
///
///Input: nums = [1,7,3,6,5,6]
///Output: 3
///Explanation:
///The pivot index is 3.
///Left sum = nums[0] + nums[1] + nums[2] = 1 + 7 + 3 = 11
///Right sum = nums[4] + nums[5] = 5 + 6 = 11
///
///Input: nums = [1,2,3]
///Output: -1
///Explanation:
///There is no index that satisfies the conditions in the problem statement.
///
///Input: nums = [2,1,-1]
///Output: 0
///Explanation:
///The pivot index is 0.
///Left sum = 0 (no elements to the left of index 0)
///Right sum = nums[1] + nums[2] = 1 + -1 = 0
func findPivotIndexUsingSum(_ nums: [Int]) -> Int {
    for index in 0..<nums.count {
        let leftSum = nums.prefix(index).reduce(0, +)
        let rightSum = nums.suffix(from: index + 1).reduce(0, +)
        
        if rightSum == leftSum {
            return index
        }
    }
    return -1
}
    //print(findPivotIndexUsingSum([2,1,-1]))

func findPivotIndexOptimisedUsingO_N(_ nums: [Int]) -> Int {
    var totalSum = nums.reduce(0, +)
    var currentSum = 0
    
    for (index, value) in nums.enumerated() {
        if currentSum == totalSum - currentSum - value {
            return index
        }
        
        currentSum += value
    }
    
    return -1
}
//print(findPivotIndexOptimisedUsingO_N([1,7,3,6,5,6]))
