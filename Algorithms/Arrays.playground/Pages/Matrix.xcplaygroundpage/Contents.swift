import Foundation

var row = 3
var column = 3
var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: column), count: row)

func initMatrix() {
    var index = 1
    for rowIndex in 0..<row {
        for columnIndex in 0..<column {
//            matrix[rowIndex][columnIndex] = Int.random(in: 0...10)
            matrix[rowIndex][columnIndex] = index
            index += 1
        }
    }
    
    print("_________Original Matrix________________")
    for rowIndex in 0..<row {
        for columnIndex in 0..<column {
            print("\(matrix[rowIndex][columnIndex]), ", terminator: "")
        }
        print("")
    }
}
initMatrix()

//MARK: - Traverse a given Matrix using Recursion
/*
 Input: arr[][] =
 {{1, 2, 3},
 {4, 5, 6},
 {7, 8, 9}}
 Output: 1, 2, 3, 4, 5, 6, 7, 8, 9
 */
///https://www.geeksforgeeks.org/traverse-a-given-matrix-using-recursion/
func matrixTraversalUsingRecursion(array matrix: [[Int]], currentRow: Int, currentColumn: Int) {
    let maxRow = matrix.count
    if maxRow > 0, let maxColumn = matrix.first?.count {
        if currentRow < maxRow {
            if currentColumn < maxColumn {
                print("\(matrix[currentRow][currentColumn]), ", terminator: "")
                matrixTraversalUsingRecursion(array: matrix, currentRow: currentRow, currentColumn: currentColumn + 1)
            } else {
                print("")
                matrixTraversalUsingRecursion(array: matrix, currentRow: currentRow + 1, currentColumn: 0)
            }
        }
    }
}
//print("_________Original Matrix traversal through recursion________________")
//matrixTraversalUsingRecursion(array: matrix, currentRow: 0, currentColumn: 0)


//MARK: Find the transpose of a matrix
/*
 Transpose of a matrix is obtained by changing rows to columns and columns to rows. In other words, transpose of A[N][M] is obtained by changing A[i][j] to A[j][i].
*/
///https://www.geeksforgeeks.org/program-to-find-transpose-of-a-matrix/
func matrixTranspose(array matrix: [[Int]]) {
    print("_________transposed matrix________________")
    let totalRows = matrix.count
    if let totalColumns = matrix.first?.count {
        for columnIndex in 0..<totalColumns {
            for rowIndex in 0..<totalRows {
                print("\(matrix[rowIndex][columnIndex]), ", terminator: "")
            }
            print("")
        }
    }
}

func matrixTransposeInverseIndex(array matrix: [[Int]]) {
    print("_________transposed matrix by inverse index________________")
    let totalRows = matrix.count
    if let totalColumns = matrix.first?.count {
        for rowIndex in 0..<totalRows {
            for columnIndex in 0..<totalColumns {
                print("\(matrix[columnIndex][rowIndex]), ", terminator: "")
            }
            print("")
        }
    }
}
matrixTransposeInverseIndex(array: matrix)


//MARK: - Search in a matrix - Matrix is sorted
///https://www.geeksforgeeks.org/search-element-sorted-matrix/
///Time complexity (m + log n)
func searchInMatrix(array matrix: [[Int]], number search: Int) -> (Int, Int) {
    let totalRows = matrix.count
    
    for rowIndex in 0 ..< totalRows {
        let totalColumns = matrix[rowIndex].count
        if search >= matrix[rowIndex][0] && search <= matrix[rowIndex][totalColumns - 1] {
            if search == matrix[rowIndex][0] {
                return (rowIndex, 0)
            } else if search == matrix[rowIndex][totalColumns - 1] {
                return (rowIndex, totalColumns - 1)
            } else {
                var lo = 0
                var hi = totalColumns - 1
                var mid = (hi + lo) / 2
                
                while lo < hi {
                    if matrix[rowIndex][mid] == search {
                        return (rowIndex, mid)
                    } else if matrix[rowIndex][mid] < search {
                        lo = mid + 1
                    } else {
                        hi = mid - 1
                    }
                }
            }
        }
    }
    
    return (-1, -1)
}
//let index = searchInMatrix(array: matrix, number: 5)
//print("Found at index \(index.0), \(index.1)")


//MARK: - Print diagonals of a matrix
///https://www.geeksforgeeks.org/program-to-print-the-diagonals-of-a-matrix/
func printMatrixDiagonals(array matrix: [[Int]]) {
    var principalDiagonal: [Int] = []
    var secondaryDiagonal: [Int] = []
    let totalRows = matrix.count
    for rowIndex in 0..<totalRows {
        let totalColumns = matrix[rowIndex].count
        for columnIndex in 0..<totalColumns {
            if columnIndex == rowIndex {
                principalDiagonal.append(matrix[rowIndex][columnIndex])
            }
            if columnIndex == (totalColumns - 1) - rowIndex {
                secondaryDiagonal.append(matrix[rowIndex][columnIndex])
            }
        }
    }
    
    print("Principal diagonal is \(principalDiagonal)")
    print("Secondary diagonal is \(secondaryDiagonal)")
}
//printMatrixDiagonals(array: matrix)


//MARK: - Sort a matrix
///https://www.geeksforgeeks.org/sort-given-matrix/
private func insertionSort(_ array: [Int]) -> [Int] {
    var arr = array
    var i = 1
    while i < arr.count {
        let key = arr[i]
        var j = i - 1
        
        while j >= 0 && arr[j] > key {
            arr[j + 1] = arr[j]
            j -= 1
        }
        
        arr[j + 1] = key
        i += 1
    }

    return arr
}

func sortMatrix(array matrix: [[Int]]) {
    var newMatrix = matrix
    var linearArray: [Int] = []
    for rowItem in matrix {
        for columnItem in rowItem {
            linearArray.append(columnItem)
        }
    }
    
    linearArray = insertionSort(linearArray)
    var index = 0
    
    for rowIndex in 0..<matrix.count {
        for columnIndex in 0..<matrix[rowIndex].count {
            newMatrix[rowIndex][columnIndex] = linearArray[index]
            index += 1
        }
    }
    
    print("______________________Sorted matrix______________________")
    for rowItem in newMatrix {
        for columnItem in rowItem {
            print("\(columnItem), ", terminator: "")
        }
        print("")
    }
}
//sortMatrix(array: matrix)


//MARK: - Matrix Rotation
//MARK: Rotate a Matrix by 90 degree
/*
 Input :
 1  2  3
 4  5  6
 7  8  9
 Output :
 3 6 9
 2 5 8
 1 4 7
 
 */
///Given a square matrix, the task is that turn it by 90 degrees in an anti-clockwise direction without using any extra space.
///https://www.geeksforgeeks.org/rotate-matrix-180-degree/
func rotateMatrixby90(array matrix: [[Int]]) {
    print("______________________90 rotation matrix______________________")
    let totalRows = matrix.count
    let totalColumns = matrix[0].count
    for columnIndex in stride(from: totalColumns - 1, to: -1, by: -1) {
        for rowIndex in 0..<totalRows {
            print("\(matrix[rowIndex][columnIndex]), ", terminator: "")
        }
        print("")
    }
}
//rotateMatrixby90(array: matrix)


//MARK: Rotate a Matrix by 180 degree
/*
 Input :
 1  2  3
 4  5  6
 7  8  9
 Output :
 9 8 7
 6 5 4
 3 2 1
 */
///Given a square matrix, the task is that turn it by 180 degrees in an anti-clockwise direction without using any extra space.
///https://www.geeksforgeeks.org/rotate-matrix-180-degree/
func rotateMatrixby180(array matrix: [[Int]]) {
    print("______________________180 rotation matrix______________________")
    let totalRows = matrix.count
    for rowIndex in stride(from: totalRows - 1, to: -1, by: -1) {
        var totalColumns = matrix[rowIndex].count
        for columnIndex in stride(from: totalColumns - 1, to: -1, by: -1) {
            print("\(matrix[rowIndex][columnIndex]), ", terminator: "")
        }
        print("")
    }
}
//rotateMatrixby180(array: matrix)

//MARK: Rotate a Matrix by 270 degree
/*
 Input :
 1  2  3
 4  5  6
 7  8  9
 Output :
 7 4 1
 8 5 2
 9 6 3
 
 */
///Given a square matrix, the task is that turn it by 270 degrees in an anti-clockwise direction without using any extra space.
///https://www.geeksforgeeks.org/rotate-matrix-180-degree/
func rotateMatrixby270(array matrix: [[Int]]) {
    print("______________________270 rotation matrix______________________")
    let totalRows = matrix.count
    let totalColumns = matrix[0].count
    for columnIndex in 0..<totalColumns {
        for rowIndex in stride(from: totalRows - 1, to: -1, by: -1) {
            print("\(matrix[rowIndex][columnIndex]), ", terminator: "")
        }
        print("")
    }
}
//rotateMatrixby270(array: matrix)


//MARK: - Find unique elements in matrix
/*
 Given a matrix mat[][] having n rows and m columns. We need to find unique elements in the matrix i.e, those elements not repeated in the matrix or those whose frequency is 1
 */
///https://www.geeksforgeeks.org/find-unique-elements-matrix/
func findUniqueElementsInMatrix(array matrix: [[Int]]) {
    print("______________________Find unique elements______________________")
    var uniqueDict: [Int : Int] = [:]
    
    for rows in matrix {
        for item in rows {
            if uniqueDict[item] == nil {
                uniqueDict[item] = 1
            } else {
                uniqueDict[item] = (uniqueDict[item] ?? 0) + 1
            }
        }
    }
    
    for (key, value) in uniqueDict {
        print("For \(key) repeat is \(value)")
    }
}
//findUniqueElementsInMatrix(array: matrix)
