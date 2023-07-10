    //
    //  BasicLRU.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 10/05/23.
    //

import Foundation

class BasicLRU<T: Equatable>: Collection, Equatable {
    typealias CollectionType = [T]
    let syncQueue = DispatchQueue(label: "BasicLRU", attributes: .concurrent)
    private var _list: CollectionType = []
    private var list: CollectionType {
        get {
            syncQueue.sync {
                _list
            }
        } set {
            syncQueue.sync(flags: .barrier) {
                _list = newValue
            }
        }
    }
    private let maxSize: Int
    
    init(_ list: CollectionType = CollectionType(), maxSize size: Int) {
        if size <= 0 {
            fatalError("List size cannot be zero or less than zero!!!")
        }
        
        self.maxSize = size
        self.append(list)
    }
}

extension BasicLRU {
    static func == (lhs: BasicLRU<T>, rhs: BasicLRU<T>) -> Bool {
        lhs === rhs
    }
}

extension BasicLRU {
    typealias Index = CollectionType.Index
    typealias Element = CollectionType.Element
    
    var startIndex: CollectionType.Index {
        list.startIndex
    }
    
    var endIndex: CollectionType.Index {
        list.endIndex
    }
    
    subscript(position: Index) -> Element {
        list[position]
    }
    
    func index(after i: Index) -> Index {
        list.index(after: i)
    }
}

extension BasicLRU {
    private func adjustListSize() {
        while list.count > 0,
              list.count > maxSize,
              maxSize > 0 {
            list.remove(at: 0)
        }
    }
    
    func append(_ values: [T]) {
        for value in values {
            append(value)
        }
    }
    
    func append(_ value: T) {
        if list.contains(where: { $0 == value }) {
            if let newValue = remove(value) {
                append(newValue)
                return
            }
        }
        adjustListSize()
        list.append(value)
    }
    
    @discardableResult func remove(at index: Int) -> T? {
        guard list.count > index else {
            return nil
        }
        
        return list.remove(at: index)
    }
    
    @discardableResult func remove(_ element: T) -> T? {
        if let index = list.firstIndex(of: element) {
            return list.remove(at: index)
        }
        
        return nil
    }
}

    //extension BasicLRU: Sequence {
    //    func makeIterator() -> some IteratorProtocol {
    //        return BasicLRUIterator(list)
    //    }
    //}
    //
    //class BasicLRUIterator<T: Equatable>: IteratorProtocol {
    //    private let values: [T]
    //    private var index: Int?
    //
    //    init(_ values: [T]) {
    //        self.values = values
    //    }
    //
    //    private func nextIndex(for index: Int?) -> Int? {
    //        if let index = index, index < self.values.count - 1 {
    //            return index + 1
    //        }
    //        if index == nil, !self.values.isEmpty {
    //            return 0
    //        }
    //        return nil
    //    }
    //
    //    func next() -> T? {
    //        if let index = self.nextIndex(for: self.index) {
    //            self.index = index
    //            return self.values[index]
    //        }
    //        return nil
    //    }
    //}
