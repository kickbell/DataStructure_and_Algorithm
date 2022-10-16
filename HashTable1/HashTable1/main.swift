//
//  main.swift
//  HashTable1
//
//  Created by jc.kim on 10/15/22.
//

import Foundation

/*
struct Car: Hashable {
    var name: String
    var price: Int
    var codeName: String
}

struct Human: Hashable {
    var age: String
    var name: String
}

let car = Car(name: "그랜져", price: 30_000_000, codeName: "DH330")
let car2 = Car(name: "그랜져", price: 30_000_000, codeName: "DH330")
let human = Human(age: "35살", name: "김개똥")

//또 Hashable를 준수하면 구조체끼리도 비교할 수 있다.
print(car.hashValue) //-5235493752956059578
print(car2.hashValue) //-5235493752956059578, 내부데이터가 같기때문에 해시값도 똑같다.
print(human.hashValue) //1058167045924687262
print(car.hashValue == human.hashValue)
 */


//데이터를 저장할 해시 테이블 생성
var hashTable = (0..<8).map { _ in "" }
print(hashTable)

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
    hashTable[hashAddress] = value //생성한 해시 테이블에 해시 주소를 index 값으로 해서 데이터를 저장
}

func readData(data: String) -> String {
    let key = getKey(data: data)
    let hashAddress = hashFunction(key: key)
    return hashTable[hashAddress]
}

saveData(data: "사과", value: "10_000")
saveData(data: "포도", value: "20_000")
saveData(data: "수박", value: "30_000")

print(readData(data: "수박"))
print(hashTable)



typealias HashAddress = Int
