//
//  main.swift
//  HashTable2
//
//  Created by jc.kim on 10/16/22.
//

import Foundation



/*
 #### 6.1. Chaining 기법
 - **개방 해슁 또는 Open Hashing 기법** 중 하나: 해쉬 테이블 저장공간 외의 공간을 활용하는 기법
 - 충돌이 일어나면, 링크드 리스트라는 자료 구조를 사용해서, 링크드 리스트로 데이터를 추가로 뒤에 연결시켜서 저장하는 기법
 */

typealias hashKey = Int
typealias hashValue = String
typealias HashAddress = Int

//데이터를 저장할 해시 테이블 생성
var hashTable: [[(key: hashKey, value: hashValue)]] = (0..<8).map { _ in [(0, "")] }
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
    
    if let firstKey = hashTable[hashAddress].first?.key, firstKey == 0 {
        //hashTable -> [[(key: hashKey, value: hashValue)]] 이고,
        //hashTable[hashAddress] -> [(key: hashKey, value: hashValue)] 이다.
        //첫번쨰 데이터의 키값이 0 이라는 것은 초기값 [(0, "")] 이라는 것이므로 아직 데이터가 들어가기 전이라는 말이다.
        //그래서 데이터를 추가해준다.
        hashTable[hashAddress] = [(key, value)]
    } else {
        //그렇지 않다는 것은 이미 데이터가 1개 들어가있다는 소리다. 충돌 Collision 난다는 거다.
        //그리고 그걸 Chaining 방법으로 해결하려고 한다.
        //원래대로라면 여기가 링크드리스트를 따로 구현해서 한다고 하는데, 지금은 hashTable -> [[(key: hashKey, value: hashValue)]]
        //와 같은 식으로 그냥 배열과 튜플을 이용해서 for 문으로 같은 효과를 보면서 작업해 주려고 한다.
        hashTable[hashAddress].append((key: key, value: value))
    }
}

func readData(data: String) -> String {
    let key = getKey(data: data)
    let hashAddress = hashFunction(key: key)
    
    if let firstKey = hashTable[hashAddress].first?.key, firstKey == 0 {
        return "" //데이터 없음
    } else {
        for index in 0..<hashTable[hashAddress].count {
            if hashTable[hashAddress][index].key == key {
                return hashTable[hashAddress][index].value
            }
        }
        return ""
    }
}


/*
 해시값이 실행할 떄마다 달라지기 떄문에 충돌을 내려면 여러번 실행해야하는데 정상적으로 충돌이 나면 아래처럼 나오게 된다.
 ====totalData====
 [(key: 0, value: "")]
 [(key: 0, value: "")]
 [(key: -7067232576260731650, value: "10_000"), (key: 8145960162044253770, value: "20_000")]
 [(key: 0, value: "")]
 [(key: 0, value: "")]
 [(key: 0, value: "")]
 [(key: 0, value: "")]
 [(key: 0, value: "")]
 */


saveData(data: "사과", value: "10_000")
saveData(data: "포도", value: "20_000")

print("\n====readData====")
print(readData(data: "사과"))

print("\n====totalData====")
hashTable.forEach { print($0) }





