//
//  main.swift
//  Greedy
//
//  Created by jc.kim on 10/26/22.
//

import Foundation

let coins = [500, 50, 1, 100]

func minCoinCount(_ price: Int, coins: [Int]) -> (Int, [(Int, Int)]) {
    var totalCoinCount = 0
    var history: [(Int, Int)] = []
    var inputPrice = price
    let sortedCoins = coins.sorted(by: >)
    
    for coin in sortedCoins {
        let coinNum = inputPrice / coin
        totalCoinCount += coinNum
        inputPrice -= coinNum * coin
        history.append((coin, coinNum))
    }
    
    return (totalCoinCount, history)
}


print(minCoinCount(4720, coins: coins))
