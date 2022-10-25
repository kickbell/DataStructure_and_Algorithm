//
//  main.swift
//  BinarySearch
//
//  Created by jc.kim on 10/25/22.
//

import Foundation

func processTime(closure: () -> ()){
    let start = CFAbsoluteTimeGetCurrent()
    closure()
    let processTime = CFAbsoluteTimeGetCurrent() - start
    print("경과 시간: \(processTime)\n")
}

/*
 중요 부분
 1. array[mediumIndex...]
 2. array[..<mediumIndex] // ...으로 하면 터지는데 잘 이해가 안가긴 한다. 
 */
func binarySearch1(_ array: [Int], searchData: Int) -> Bool {
    //제일 마지막까지 데이터를 나누고 마지막 데이터가 찾는 데이터인 경우
    if array.count == 1 && searchData == array.first ?? 0 { return true }
    //제일 마지막까지 데이터를 나누고, 찾는 데이터가 없는 경우
    if array.count == 1 && searchData != array.first ?? 0 { return false }
    
    let mediumIndex = array.count / 2
    
    //제일 마지막까지 나누지 않았어도 데이터를 찾은 경우
    if searchData == array[mediumIndex] { return true }
    
    //그렇지 않은 경우
    if searchData > array[mediumIndex] {
        return binarySearch1(Array(array[mediumIndex...]), searchData: searchData)
    } else {
        //..< 이게 중요한데.. 흠 정확히는 모르겠.
        return binarySearch1(Array(array[..<mediumIndex]), searchData: searchData)
    }
}

/*
 중요 부분
 1. if startIndex > endIndex { return false }
 2. mediumIndex + 1,  mediumIndex - 1
 */
func binarySearch2(_ array: [Int],_ searchData: Int, _ startIndex: Int,_ endIndex: Int) -> Bool {
    if startIndex > endIndex { return false } //중요
    
    let mediumIndex = (startIndex + endIndex) / 2
    
    //제일 마지막까지 나누지 않았어도 데이터를 찾은 경우
    if searchData == array[mediumIndex] { return true}
    
    if searchData > array[mediumIndex] {
        return binarySearch2(array, searchData, mediumIndex + 1, endIndex)
    } else {
        return binarySearch2(array, searchData, startIndex, mediumIndex - 1)
    }
}



/*
 수 찾기
 https://www.acmicpc.net/problem/1920
 
 문제가 이해하기가 약간 어렵다. 뭐 모든 문제가 그렇긴 하지.
 근데 그냥 이거다. 5개의 숫자를 가진 input 4 1 5 2 3 이 있고, 마찬가지로 5개의 숫자를 가진 1 3 7 9 5 이 있다.
 
 N = 5
 N_list = [4 1 5 2 3]
 M = 5
 M_list = [1 3 7 9 5]
 
 여기서부터 찾는거다.
 
 M_list에서 1이 N_list에 포함되면 1, 아니면 0 -> 1
 M_list에서 3이 N_list에 포함되면 1, 아니면 0 -> 1
 M_list에서 7이 N_list에 포함되면 1, 아니면 0 -> 0
 M_list에서 9이 N_list에 포함되면 1, 아니면 0 -> 0
 M_list에서 5이 N_list에 포함되면 1, 아니면 0 -> 1
 */


let N = 5
let N_list = [4, 1, 5, 2, 3]
let M = 5
let M_list = [1, 3, 7, 9, 5]

func find1(_ nlist: [Int],_ mlist: [Int]) {
    for m in mlist {
        if nlist.contains(m) {
//            print("1")
        } else {
//            print("0")
        }
    }
}


func find2(_ nlist: [Int],_ mlist: [Int]) {
    for m in mlist {
        if binarySearch1(nlist, searchData: m) {
//            print("1")
        } else {
//            print("0")
        }
    }
}

func find3(_ nlist: [Int],_ mlist: [Int]) {
    let sortedArray = nlist.sorted()
    
    for m in mlist {
        if binarySearch2(sortedArray, m, 0, sortedArray.count - 1) {
//            print("1")
        } else {
//            print("0")
        }
    }
}

print("\n===수찾기 find1===")
find1(N_list, M_list)

print("\n===수찾기 find2===")
let nlist = N_list.sorted()
find2(nlist, M_list)

print("\n===수찾기 find3===")
find3(nlist, M_list)



print("\n===경과 시간 비교===")
/*
 경과 시간: 0.019398927688598633

 경과 시간: 0.0088731050491333

 경과 시간: 0.006464958190917969
 */

let list1 = (1...1000).map { _ in Int.random(in: 1...100)}
let list2 = (1...1000).map { _ in Int.random(in: 1...100)}

processTime {
        find1(list1, list2)
}

processTime {
        let sortedList = list1.sorted()
        find2(sortedList, list2)
}

processTime {
        let sortedList = list1.sorted()
        find3(sortedList, list2)
}
