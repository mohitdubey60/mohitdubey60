import Foundation

var arr = [64,25,12,22,11]

/*
 The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from the unsorted part and putting it at the beginning.
 
 The algorithm maintains two subarrays in a given array.
 
 The subarray which already sorted.
 The remaining subarray was unsorted.
 In every iteration of the selection sort, the minimum element (considering ascending order) from the unsorted subarray is picked and moved to the sorted subarray.
 
 ```
 Lets consider the following array as an example: arr[] = {64, 25, 12, 22, 11}
 
 First pass:
 For the first position in the sorted array, the whole array is traversed from index 0 to 4 sequentially. The first position where 64 is stored presently, after traversing whole array it is clear that 11 is the lowest value.
 64          25          12          22          11
 Thus, replace 64 with 11. After one iteration 11, which happens to be the least value in the array, tends to appear in the first position of the sorted list.
 11          25          12          22          64
 
 Second Pass:
 For the second position, where 25 is present, again traverse the rest of the array in a sequential manner.
 11          25          12          22          64
 After traversing, we found that 12 is the second lowest value in the array and it should appear at the second place in the array, thus swap these values.
 11          12          25          22          64
 
 Third Pass:
 Now, for third place, where 25 is present again traverse the rest of the array and find the third least value present in the array.
 11          12          25          22          64
 While traversing, 22 came out to be the third least value and it should appear at the third place in the array, thus swap 22 with element present at third position.
 11          12          22          25          64
 
 Fourth pass:
 Similarly, for fourth position traverse the rest of the array and find the fourth least element in the array
 As 25 is the 4th lowest value hence, it will place at the fourth position.
 11          12          22          25          64
 
 Fifth Pass:
 At last the largest value present in the array automatically get placed at the last position in the array
 The resulted array is the sorted array.
 11          12          22          25          64
 ```
 */
//MARK: - Selection sorting
func selectionSorting(_ array: [Int]) {
    var arr = array
    print("Before sorting \(arr)")
    
    var i = 0
    
    while i < arr.count - 1 {
        var min_index = i
        var j = i + 1
        
        while j < arr.count {
            if arr[j] < arr[min_index] {
                min_index = j
            }
            
            j += 1
        }
        
        var temp = arr[min_index]
        arr[min_index] = arr[i]
        arr[i] = temp
        
        print("Each loop \(arr)")
        i += 1
    }
    
    print("Final array \(arr)")
}
//selectionSorting(arr)


/*
 Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in the wrong order. This algorithm is not suitable for large data sets as its average and worst-case time complexity is quite high.
 
 Input: arr[] = {5, 1, 4, 2, 8}
 
 First Pass:
 Bubble sort starts with very first two elements, comparing them to check which one is greater.
 ( 5 1 4 2 8 ) –> ( 1 5 4 2 8 ), Here, algorithm compares the first two elements, and swaps since 5 > 1.
 ( 1 5 4 2 8 ) –>  ( 1 4 5 2 8 ), Swap since 5 > 4
 ( 1 4 5 2 8 ) –>  ( 1 4 2 5 8 ), Swap since 5 > 2
 ( 1 4 2 5 8 ) –> ( 1 4 2 5 8 ), Now, since these elements are already in order (8 > 5), algorithm does not swap them.
 
 Second Pass:
 Now, during second iteration it should look like this:
 ( 1 4 2 5 8 ) –> ( 1 4 2 5 8 )
 ( 1 4 2 5 8 ) –> ( 1 2 4 5 8 ), Swap since 4 > 2
 ( 1 2 4 5 8 ) –> ( 1 2 4 5 8 )
 ( 1 2 4 5 8 ) –>  ( 1 2 4 5 8 )
 
 Third Pass:
 Now, the array is already sorted, but our algorithm does not know if it is completed.
 The algorithm needs one whole pass without any swap to know it is sorted.
 ( 1 2 4 5 8 ) –> ( 1 2 4 5 8 )
 ( 1 2 4 5 8 ) –> ( 1 2 4 5 8 )
 ( 1 2 4 5 8 ) –> ( 1 2 4 5 8 )
 ( 1 2 4 5 8 ) –> ( 1 2 4 5 8 )
 */
//MARK: - Bubble sorting
func bubbleSort(_ array: [Int]) {
    print("Original array is \(arr)")
    var arr = array
    var i = 0
    
    while i < arr.count {
        var j = 0
        while j < arr.count - i - 1 {
            if arr[j + 1] < arr[j] {
                let temp = arr[j]
                arr[j] = arr[j + 1]
                arr[j + 1] = temp
            }
            print("After inner loop the array is \(arr)")
            j += 1
        }
        print("After outer loop the array is \(arr)\n\n")
        i += 1
    }
    
    print("Sorted array is \(arr)")
}
//bubbleSort(arr)


/*

*/
//MARK: - Merge sorting

//private func divideAndConquer(_ left: [Int], _ right: [Int]) -> [Int] {
//    print("Array 1 is \(left) and Array2 is \(right)")
//
//    if left.count > 1 {
//        let mid = left.count / 2
//        let leftAr = Array(left.prefix(upTo: mid))
//        let rightAr = Array(left.suffix(from: mid))
//
//        divideAndConquer(leftAr, rightAr)
//    }
//
//    if right.count > 1 {
//        let mid = right.count / 2
//        let leftAr = Array(right.prefix(upTo: mid))
//        let rightAr = Array(right.suffix(from: mid))
//
//        divideAndConquer(leftAr, rightAr)
//    }
//
//
//    print("-------------------------Post recursion-------------------------")
//    print("Array 1 is \(left) and Array2 is \(right)")
//
//    var leftIndex = 0
//    var rightIndex = 0
//    var tempArr: [Int] = []
//    while leftIndex < left.count && rightIndex < right.count {
//        if left[leftIndex] < right[rightIndex] {
//            tempArr.append(left[leftIndex])
//            leftIndex += 1
//        } else {
//            tempArr.append(right[rightIndex])
//            rightIndex += 1
//        }
//    }
//
//    while leftIndex < left.count {
//        tempArr.append(left[leftIndex])
//        leftIndex += 1
//    }
//
//    while rightIndex < right.count {
//        tempArr.append(right[rightIndex])
//        rightIndex += 1
//    }
//
//
//    print("Temp array is \(tempArr)")
//    return tempArr
//}
//func mergeSort(_ array: [Int]) {
//    var arr = array
//
//    let mid = arr.count / 2
//    let left = Array(arr.prefix(upTo: mid))
//    let right = Array(arr.suffix(from: mid))
//
//    let sortedArray = divideAndConquer(left, right)
//    print("Sorted array is \(sortedArray)")
//
//}
//mergeSort(arr)


/*
 To sort an array of size N in ascending order:
 
 Iterate from arr[1] to arr[N] over the array.
 Compare the current element (key) to its predecessor.
 If the key element is smaller than its predecessor, compare it to the elements before. Move the greater elements one position up to make space for the swapped element.
 
 Consider an example: arr[]: {12, 11, 13, 5, 6}
 
 12          11          13          5          6
 
 First Pass:
 Initially, the first two elements of the array are compared in insertion sort.
 12          11          13          5          6
 Here, 12 is greater than 11 hence they are not in the ascending order and 12 is not at its correct position. Thus, swap 11 and 12.
 So, for now 11 is stored in a sorted sub-array.
 11          12          13          5          6
 
 Second Pass:
 Now, move to the next two elements and compare them
 11          12          13          5          6
 Here, 13 is greater than 12, thus both elements seems to be in ascending order, hence, no swapping will occur. 12 also stored in a sorted sub-array along with 11
 
 Third Pass:
 Now, two elements are present in the sorted sub-array which are 11 and 12
 Moving forward to the next two elements which are 13 and 5
 11          12          13          5          6
 Both 5 and 13 are not present at their correct place so swap them
 11          12          5          13          6
 After swapping, elements 12 and 5 are not sorted, thus swap again
 11          5          12          13          6
 Here, again 11 and 5 are not sorted, hence swap again
 5          11          12          13          6
 here, it is at its correct position
 
 Fourth Pass:
 Now, the elements which are present in the sorted sub-array are 5, 11 and 12
 Moving to the next two elements 13 and 6
 5          11          12          13          6
 Clearly, they are not sorted, thus perform swap between both
 5          11          12          6          13
 Now, 6 is smaller than 12, hence, swap again
 5          11          6          12          13
 Here, also swapping makes 11 and 6 unsorted hence, swap again
 5          6          11          12          13
 Finally, the array is completely sorted.
 */

//MARK: - Insertion sorting
func insertionSort(_ array: [Int]) {
    var arr = array
    print("Original array is \(arr)")
    var i = 1
    while i < arr.count {
        let key = arr[i]
        var j = i - 1
        
        while j >= 0 && arr[j] > key {
            arr[j + 1] = arr[j]
            j -= 1
            
            print("array inner loop where j is \(j) and array is \(arr)")
        }
        
        arr[j + 1] = key
        
        print("array outer loop array is \(arr)")
        i += 1
    }
    
    print("Sorted array is \(arr)")
}

insertionSort(arr)
