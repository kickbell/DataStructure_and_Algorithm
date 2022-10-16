//
//  main.swift
//  HashTable2
//
//  Created by jc.kim on 10/16/22.
//

import Foundation



/*
 #### 6.2. Linear Probing 기법
 - **폐쇄 해슁 또는 Close Hashing 기법** 중 하나: 해쉬 테이블 저장공간 안에서 충돌 문제를 해결하는 기법
 - 충돌이 일어나면, 해당 hash address의 다음 address부터 맨 처음 나오는 빈공간에 저장하는 기법
   - 저장공간 활용도를 높이기 위한 기법
 */

typealias hashKey = Int
typealias hashValue = String
typealias HashAddress = Int

//데이터를 저장할 해시 테이블 생성
var hashTable: [(key: hashKey, value: hashValue)] = (0..<8).map { _ in (0, "") }
hashTable.forEach { print($0) }

//데이터 값을 통해 키값을 반환
func getKey(data: String) -> Int {
    return data.hashValue // String, Int등은 다 Hashable을 준수하고 있어서 hashValue라는 걸로 바로 만들 수 있다. 고정된 길이의 Int를 반환
}

//해시함수를 통해 저장할 해시 주소를 반환
func hashFunction(key: Int) -> Int {
    return abs(key) % 8 //abs는 절대값. 음수키가 들어오면 양수로 바꿔주기 위해
}







func saveData(data: String, value: String) {
    let key = getKey(data: data) //데이터 값을 통해 키값을 반환
    let hashAddress = hashFunction(key: key) //해시함수를 통해 저장할 해시 주소를 반환
//    print(hashAddress, "Address")
    if hashTable[hashAddress].key == 0 {
        //데이터가 비어있다면
        hashTable[hashAddress] = (key, value)
    } else {
        //데이터가 비어있지 않다면 충돌 Collision 난다는 거다.
        //그리고 그걸 Linear Probing 방법으로 해결하려고 한다.
        //선형 탐색?너낌으로 이후를 돌아주면 되는데.
        for index in (hashAddress...hashTable.count-1) {
            if hashTable[index].key == 0 {
                //빈칸을 발견했으므로 여기다 충돌되는 데이터를 넣어주면 되겠다.
                hashTable[index] = (key, value)
                return //리턴 키워드 꼭 필요하다. 안해주면 이후 배열에 데이터 다들어감.
            } else if hashTable[index].key == key {
                //키가 같다는 것은 해당 데이터를 업데이트 한다는 것이다.
                hashTable[index].value = value
                return
            }
        }
    }
}

func readData(data: String) -> String {
    let key = getKey(data: data)
    let hashAddress = hashFunction(key: key)
    
    if hashTable[hashAddress].key == 0 {
        return ""
    } else {
        for index in (hashAddress...hashTable.count-1) {
            if hashTable[index].key == 0 {
                return ""
            } else if hashTable[index].key == key {
                return hashTable[index].value
            }
        }
        return ""
    }
}


/*
 4 Address
 4 Address
 
 ====readData====
 10_000

 ====totalData====
 (key: 0, value: "")
 (key: 0, value: "")
 (key: 0, value: "")
 (key: 0, value: "")
 (key: -6740742047845731564, value: "10_000")
 (key: 3996458706203432476, value: "20_000")
 (key: 0, value: "")
 (key: 0, value: "")
 */


saveData(data: "사과", value: "10_000")
saveData(data: "포도", value: "20_000")

print("\n====readData====")
print(readData(data: "사과"))

print("\n====totalData====")
hashTable.forEach { print($0) }






