import Foundation

var arr = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]

/*
 Binary Search is a searching algorithm used in a sorted array by repeatedly dividing the search interval in half. The idea of binary search is to use the information that the array is sorted and reduce the time complexity to O(Log n).
 Binary Search Algorithm: The basic steps to perform Binary Search are:
 - Begin with the mid element of the whole array as a search key.
 - If the value of the search key is equal to the item then return an index of the search key.
 - Or if the value of the search key is less than the item in the middle of the interval, narrow the interval to the lower half.
 - Otherwise, narrow it to the upper half.
 - Repeatedly check from the second point until the value is found or the interval is empty.
 Formula: pos = (lo + hi) / 2
 */
//MARK: - Binary search in an array
func binarySearch(_ array: [Int], search number: Int) -> Int {
    var low = 0
    var high = array.count - 1
    
    while high - low > 1 {
        var mid = (low + high) / 2
        
        if array[mid] == number {
            return mid
        }
        
        if number > array[mid] {
            low = mid + 1
        } else {
            high = mid
        }
        
        print("Mid is \(mid) low is \(low) high is \(high)")
    }
    
    return -1
}

//let index = binarySearch(arr, search: 12)
//print("Number is at index \(index)")


//MARK: - Binary search in an array using recursion
func binarySearchRecursion(_ array: [Int], search number: Int, low: Int, high: Int) -> Int {
    
    if high - low <= 0 {
        return -1
    }
    
    let mid = (high + low) / 2
    if array[mid] == number {
        return mid
    }
    
    if array[mid] < number {
        return binarySearchRecursion(array, search: number, low: mid + 1, high: high)
    }
    
    return binarySearchRecursion(array, search: number, low: low, high: mid)
}

//let index = binarySearchRecursion(arr, search: 12, low: 0, high: arr.count - 1)
//print("Number is at index \(index)")


/*
 Jump Search is a searching algorithm for sorted arrays. The basic idea is to check fewer elements (than linear search) by jumping ahead by fixed steps or skipping some elements in place of searching all elements.
 For example, suppose we have an array arr[] of size n and a block (to be jumped) of size m. Then we search in the indexes arr[0], arr[m], arr[2m]…..arr[km] and so on. Once we find the interval (arr[km] < x < arr[(k+1)m]), we perform a linear search operation from the index km to find the element x.
 Let’s consider the following array: (0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610). The length of the array is 16. The Jump search will find the value of 55 with the following steps assuming that the block size to be jumped is 4.
 STEP 1: Jump from index 0 to index 4;
 STEP 2: Jump from index 4 to index 8;
 STEP 3: Jump from index 8 to index 12;
 STEP 4: Since the element at index 12 is greater than 55, we will jump back a step to come to index 8.
 STEP 5: Perform a linear search from index 8 to get the element 55.
 
 Performance in comparison to linear and binary search:
 If we compare it with linear and binary search then it comes out then it is better than linear search but not better than binary search.
 
 The increasing order of performance is:
 
 linear search  <  jump search  <  binary search
 */
//MARK: - Jump search
func jumpSearch(_ array: [Int], search number: Int) -> Int {
    let jump = Int(sqrt(Double(array.count)))
    var jumpIndex = jump
    var loopCount = 0
    while array[(min(jumpIndex, array.count) - 1)] < number {
        if jumpIndex >= array.count {
            return -1
        }
        
        loopCount += 1
        jumpIndex = loopCount * jump
    }
    
    loopCount -= 1
    if (loopCount * jump) >= array.count {
        return -1
    }
    
    var startJumpIndex = loopCount * jump
    while startJumpIndex <= min(jumpIndex, array.count - 1) {
        if array[startJumpIndex] == number {
            return startJumpIndex
        }
        
        startJumpIndex += 1
    }
    
    return -1
}
//let index = jumpSearch(arr, search: 143)
//print("Number is at index \(index)")


/*
 The Interpolation Search is an improvement over Binary Search for instances, where the values in a sorted array are uniformly distributed. Interpolation constructs new data points within the range of a discrete set of known data points. Binary Search always goes to the middle element to check. On the other hand, interpolation search may go to different locations according to the value of the key being searched.
 Formula: pos = lo + (((hi - lo) / (arr[hi] - arr[lo])) * (number - arr[lo]))
 
 linear search  <  jump search  <  binary search < Linear Interpolation search
 
 All the algorithm is similar to bunary search except the positioning logic
 */
//MARK: - Linear Interpolation search
func linearInterpolationSearch(_ array: [Int], search number: Int) -> Int {
    var lo = 0
    var hi = array.count - 1
    
    while lo <= hi, number >= array[lo] && number <= array[hi] {
        var pos = lo + (((hi - lo) / (arr[hi] - arr[lo])) *
                        (number - arr[lo]))
        
        if array[pos] == number {
            return pos
        }
        
        if array[pos] < number {
             lo = pos + 1
        } else {
            hi = pos - 1
        }
    }
    
    return -1
}
//let index = linearInterpolationSearch(arr, search: 144)
//print("Number is at index \(index)")


//MARK: - recursive linear interpolation search
func recursiveLinearSearch(_ array: [Int], search number: Int, lo: Int, hi: Int) -> Int {
    if lo <= hi, number >= array[lo] && number <= array[hi] {
        var pos = lo + (((hi - lo) / (arr[hi] - arr[lo])) *
                        (number - arr[lo]))
        
        if array[pos] == number {
            return pos
        }
        
        if array[pos] < number {
            return recursiveLinearSearch(array, search: number, lo: pos + 1, hi: hi)
        } else {
            return recursiveLinearSearch(array, search: number, lo: lo, hi: pos - 1)
        }
    }
    
    return -1
}
let index = recursiveLinearSearch(arr, search: 144, lo: 0, hi: arr.count - 1)
print("Number is at index \(index)")
