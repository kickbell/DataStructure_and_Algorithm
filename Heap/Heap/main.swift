//
//  main.swift
//  Heap
//
//  Created by jc.kim on 10/17/22.
//

import Foundation


class Heap {
    var heapArray: [Int] = []
    
    init(value: Int) {
        self.heapArray.append(0) // 0 말고 옵셔널로 처리하거나 -1 같은걸로 처리하는 방법도 있긴 하겠는데,,
        self.heapArray.append(value)
    }
    
    //위와 아래를 바꿔줘야 되는지를 판단하는 메소드
    func moveUp(_ insertedIndex: Int) -> Bool {
        if insertedIndex <= 1 { return false } //루트 노드(insertedIndex <= 1)라면 바꿀 필요 없으니 바로 리턴
        let parentIndex = insertedIndex - 1
        return heapArray[insertedIndex] > heapArray[parentIndex]
    }
    
    func insert(_ value: Int) {
        self.heapArray.append(value)
        
        //가장 마지막 데이터의 index, 첫번째 0 넣은 길이도 포함해야 한다.
        var insertedIndex = self.heapArray.count - 1
        
        while moveUp(insertedIndex) {
            let parentIndex = insertedIndex / 2
            heapArray.swapAt(insertedIndex, parentIndex)
            insertedIndex = parentIndex
        }
    }
}


let heap = Heap(value: 15)
heap.insert(10)
heap.insert(8)
heap.insert(5)
heap.insert(4)
heap.insert(20)

print(heap.heapArray)




