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


