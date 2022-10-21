//
//  main.swift
//  RecursiveCall
//
//  Created by jc.kim on 10/21/22.
//

import Foundation

/*
 보통 1,2번과 같은 2가지 패턴으로 많이 쓰인다.
 주로 2번이 더 많이 쓰이는 것 같고.. 자기 자신을 호출하는데 꼭 -1 하거나 +1 하거나 그러곤 하지.
 */
func factorial1(_ num: Int) -> Int {
    if num > 1 {
        return num * factorial1(num - 1)
    } else {
        return num
    }
}

func factorial2(_ num: Int) -> Int {
    if num <= 1 { return num }
    return num * factorial2(num - 1)
}
    

print("\n===factorial===")
(1...10).forEach { print(factorial1($0)) }
(1...10).forEach { print(factorial2($0)) }



//1부터 num까지의 곱
//1*2*3*4*5와 같다.
func multiple1(_ num: Int) -> Int {
    var result = 1
    for index in 1...num {
        result *= index //result = result * index 와 같은 것
    }
    return result
}


func multiple2(_ num: Int) -> Int {
    if num <= 1 { return num }
    return num * multiple2(num - 1)
}

print("\n===multiple===")
print(multiple1(5))
print(multiple2(5))


//숫자가 들어가있는 리스트가 있을 때 그 합을 구해라

let list = [1,2,3,4,5]

func sumList1(_ array: [Int]) -> Int {
    var result = 0
    for num in array {
        result += num
    }
    return result
}

func sumList2(_ array: [Int]) -> Int {
    return array.reduce(0, +)
}

func sumList3(_ array: [Int]) -> Int {
    var result = array
    if result.count <= 1 { return result.first ?? 0 }
    return result.removeFirst() + sumList3(result) //이렇게도 할 수 있고
}

func sumList4(_ array: [Int]) -> Int {
    let result = array
    if result.count <= 1 { return result.first ?? 0 }
    return (result.first ?? 0) + sumList4(Array(result[1...])) //이렇게 처리할 수도 있겠습니다.
}

print("\n===sumList===")
print(sumList1(list))
print(sumList2(list))
print(sumList3(list))
print(sumList4(list))


//회문, 앞뒤로바꿔도 똑같은지, 기러기/오디오/역삼역/level...
func palindrome1(_ word: String) -> Bool {
    let reversedWord = word.reversed().map {"\($0)"}.joined()
    return word == reversedWord
}

func palindrome2(_ word: String) -> Bool {
    if word.count <= 1 { return true }

    //위에서 1보다 크다는게 통과되었기 떄문에 옵셔널 강제추출을 사용
    if word.first! == word.last! {
        // 파이썬 기준으로 하면 first, last를 제외한 나머지 단어를 이렇게 해서 array[1:-1] 재호출
        let wordArray = word.map { "\($0)"}
        let newWord = wordArray[1...wordArray.count-2].joined()
        return palindrome2(newWord)
    } else {
        return false
    }
}

print("\n===palindrome1===")

print(palindrome1("level"))
print(palindrome1("levzl"))
print(palindrome1("madam"))
print(palindrome1("madem"))
print(palindrome1("kayak"))
print(palindrome1("kaydk"))

print("\n===palindrome2===")

print(palindrome2("level"))
print(palindrome2("levzl"))
print(palindrome2("madam"))
print(palindrome2("madem"))
print(palindrome2("kayak"))
print(palindrome2("kaydk"))


/*
 프로그래밍 연습
 1, 정수 n에 대해
 2. n이 홀수이면 3 X n + 1 을 하고,
 3. n이 짝수이면 n 을 2로 나눕니다.
 4. 이렇게 계속 진행해서 n 이 결국 1이 될 때까지 2와 3의 과정을 반복합니다.

 예를 들어 n에 3을 넣으면,
 3
 10
 5
 16
 8
 4
 2
 1
 이 됩니다.
 이렇게 정수 n을 입력받아, 위 알고리즘에 의해 1이 되는 과정을 모두 출력하는 함수를 작성하세요.
 */

func calculation1(_ num: Int) {
    print("n: \(num)")
    
    var n = num
    while n != 1 {
        if n % 2 == 0 {
            n = n / 2
        } else {
            n = 3 * n + 1
        }
        print("n: \(n)")
    }
}

func calculation2(_ num: Int) {
    print("n: \(num)")
    //대부분은 혹시 놓칠 케이스 때문에 <= 1 이렇게 하는데, 여기서는 문제에서 1 이라고 명시가 되어있어서 그냥 1로.
    if num == 1 { return }
    calculation2((num % 2 == 0) ? (num / 2) : (3 * num) + 1)
}

print("\n===calculation1===")
calculation1(3)
print("\n===calculation2===")
calculation2(3)




/*
 프로그래밍 연습
 문제: 정수 4를 1, 2, 3의 조합으로 나타내는 방법은 다음과 같이 총 7가지가 있음
 1+1+1+1
 1+1+2
 1+2+1
 2+1+1
 2+2
 1+3
 3+1
 정수 n이 입력으로 주어졌을 때, n을 1, 2, 3의 합으로 나타낼 수 있는 방법의 수를 구하시오
 힌트: 정수 n을 만들 수 있는 경우의 수를 리턴하는 함수를 f(n) 이라고 하면,
 f(n)은 f(n-1) + f(n-2) + f(n-3) 과 동일하다는 패턴 찾기
 출처: ACM-ICPC > Regionals > Asia > Korea > Asia Regional - Taejon 2001
 */
