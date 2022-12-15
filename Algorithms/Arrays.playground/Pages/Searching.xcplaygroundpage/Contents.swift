import Foundation

var arr = [11, 12, 22, 25, 64]

/*
 Binary Search is a searching algorithm used in a sorted array by repeatedly dividing the search interval in half. The idea of binary search is to use the information that the array is sorted and reduce the time complexity to O(Log n).
 Binary Search Algorithm: The basic steps to perform Binary Search are:
 - Begin with the mid element of the whole array as a search key.
 - If the value of the search key is equal to the item then return an index of the search key.
 - Or if the value of the search key is less than the item in the middle of the interval, narrow the interval to the lower half.
 - Otherwise, narrow it to the upper half.
 - Repeatedly check from the second point until the value is found or the interval is empty.
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

let index = binarySearchRecursion(arr, search: 12, low: 0, high: arr.count - 1)
print("Number is at index \(index)")
