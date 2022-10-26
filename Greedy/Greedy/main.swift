//
//  main.swift
//  Greedy
//
//  Created by jc.kim on 10/26/22.
//

import Foundation

/*
 ### 문제1: 동전 문제
   - 지불해야 하는 값이 4720원 일 때 1원 50원 100원, 500원 동전으로 동전의 수가 가장 적게 지불하시오.
     - 가장 큰 동전부터 최대한 지불해야 하는 값을 채우는 방식으로 구현 가능
     - 탐욕 알고리즘으로 매순간 최적이라고 생각되는 경우를 선택하면 됨
 */
let coins = [500, 50, 1, 100]

func minCoinCount(price: Int, coins: [Int]) -> (Int, [(Int, Int)]) {
    var totalCoinCount = 0
    var history: [(Int, Int)] = []
    var price = price
    let sortedCoins = coins.sorted(by: >) //[500, 100, 50, 1], reverse
    
    for coin in sortedCoins {
        let coinNum = price / coin
        totalCoinCount += coinNum
        price -= coinNum * coin
        history.append((coin, coinNum))
    }
    
    return (totalCoinCount, history)
}

print("\n===동전 문제===")
print(minCoinCount(price: 4720, coins: coins))


/*
 ### 문제2: 부분 배낭 문제 (Fractional Knapsack Problem)
   - 무게 제한이 k인 배낭에 최대 가치를 가지도록 물건을 넣는 문제
     - 각 물건은 무게(w)와 가치(v)로 표현될 수 있음
     - 물건은 쪼갤 수 있으므로 물건의 일부분이 배낭에 넣어질 수 있음, 그래서 Fractional Knapsack Problem 으로 부름
       - Fractional Knapsack Problem 의 반대로 물건을 쪼개서 넣을 수 없는 배낭 문제도 존재함 (0/1 Knapsack Problem 으로 부름)
     <img src="https://www.fun-coding.org/00_Images/knapsack.png">
 */

typealias Bag = (weight: Double, value: Double)
typealias History = (weight: Double, value: Double, percent: Double)
typealias ReturnValue = (totalValue: Double, history: [History])

func maxValue(_ bags: [Bag],
              _ limitWeight: Double) -> ReturnValue {
    let sortedBags = bags.sorted { $0.value/$0.weight > $1.value/$1.weight } //더 높은 가치순으로 정렬
    var totalValue: Double = 0
    var history: [History] = []
    var limitWeight = limitWeight
    
    for bag in sortedBags {
        if limitWeight - bag.weight >= 0 {
            //더 넣을 공간이 남아있다면
            limitWeight -= bag.weight
            totalValue += bag.value
            history.append((bag.weight, bag.value, 1.0))
        } else {
            //넣을거 다 넣고 쪼개서 넣는거라면
            let fraction = limitWeight / bag.weight //쪼갠부분이 1.0을 기준으로 0.?인지 계산
//            limitWeight -= bag.weight 이건 필요가 없다. 왜? 어차피 마지막이라 0보다 작거나 같을테니까
            totalValue += (bag.value * fraction) // 이 부분 중요
            history.append((bag.weight, bag.value, fraction))
            break //마지막이니 꼭 끝내줘야 한다.
        }
    }
    
    return (totalValue, history)
}

print("\n===부분 배낭 문제===")
let bags: [Bag] = [(10,10), (15,12), (20,10), (25,8), (30,5)]
let limitWeight = 30.0

let result = maxValue(bags, limitWeight)
print(result.totalValue)
print(result.history.forEach { print($0)})



/*
 ATM 인출기
 https://www.acmicpc.net/problem/11399
 
 인하은행에는 ATM이 1대밖에 없다. 지금 이 ATM앞에 N명의 사람들이 줄을 서있다. 사람은 1번부터 N번까지 번호가 매겨져 있으며, i번 사람이 돈을 인출하는데 걸리는 시간은 Pi분이다.

 사람들이 줄을 서는 순서에 따라서, 돈을 인출하는데 필요한 시간의 합이 달라지게 된다. 예를 들어, 총 5명이 있고, P1 = 3, P2 = 1, P3 = 4, P4 = 3, P5 = 2 인 경우를 생각해보자. [1, 2, 3, 4, 5] 순서로 줄을 선다면, 1번 사람은 3분만에 돈을 뽑을 수 있다. 2번 사람은 1번 사람이 돈을 뽑을 때 까지 기다려야 하기 때문에, 3+1 = 4분이 걸리게 된다. 3번 사람은 1번, 2번 사람이 돈을 뽑을 때까지 기다려야 하기 때문에, 총 3+1+4 = 8분이 필요하게 된다. 4번 사람은 3+1+4+3 = 11분, 5번 사람은 3+1+4+3+2 = 13분이 걸리게 된다. 이 경우에 각 사람이 돈을 인출하는데 필요한 시간의 합은 3+4+8+11+13 = 39분이 된다.

 줄을 [2, 5, 1, 4, 3] 순서로 줄을 서면, 2번 사람은 1분만에, 5번 사람은 1+2 = 3분, 1번 사람은 1+2+3 = 6분, 4번 사람은 1+2+3+3 = 9분, 3번 사람은 1+2+3+3+4 = 13분이 걸리게 된다. 각 사람이 돈을 인출하는데 필요한 시간의 합은 1+3+6+9+13 = 32분이다. 이 방법보다 더 필요한 시간의 합을 최소로 만들 수는 없다.

 줄을 서 있는 사람의 수 N과 각 사람이 돈을 인출하는데 걸리는 시간 Pi가 주어졌을 때, 각 사람이 돈을 인출하는데 필요한 시간의 합의 최솟값을 구하는 프로그램을 작성하시오.
 */


let timeList = [3, 1, 4, 3, 2]


/*
 되게 참신?한 방법이 쓰인다. 아래 이중포문 참고
 */
func minTotalTimeUseForLoop(_ timeList: [Int]) -> Int {
    let sortedTimeList: [Int] = timeList.sorted()
    var minTotalTime = 0
    for index in 0...timeList.count - 1 {
        for index2 in 0...index {
            //결국에 [1,2,3,3,4] 라는 리스트를 받았을 떄, 1, 1+2, 1+2+3, 1+2+3+3, 1+2+3+3+4처럼 동작해야 했다.
            //즉 0번째까지 더하기, 0~1번째까지 더하기, 0~2번째까지 더하기, 0~3번째까지 더하기, 0~4번째까지 더하기 처럼 말이다.
            //그래서 여기서는 이중포문에 0...index + 1를 써서 그걸 해결했다. 신박하다?.. 굿잡..
            //print(index, index2)
            minTotalTime += sortedTimeList[index2]
        }
    }
    return minTotalTime
}


//참고로 난 이렇게 풀었는데, 위에 선생님 풀이가 더 나은 것 같다.
func minTotalTime(_ timeList: [Int]) -> Int {
    let sortedTimeList: [Int] = timeList.sorted()
    var totalTime: Int = 0
    var history: [Int] = []
    
    for work in sortedTimeList {
        totalTime += work
        history.append(totalTime)
    }
    
    return history.reduce(0, +)
}

print("\n===ATM 인출기===")
//1. 선생님 풀이
print(minTotalTimeUseForLoop(timeList))
//2. 나의 풀이
print(minTotalTime(timeList))


