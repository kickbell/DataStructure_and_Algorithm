//
//  main.swift
//  Dijkstra
//
//  Created by jc.kim on 10/28/22.
//

import Foundation


let graph: [String: [String: Int]] = [
    "A":["B":8, "C":1, "D":2],
    "B":[:],
    "C":["B":5, "D":2],
    "D":["E":3, "F":5],
    "E":["F":1],
    "F":["A":5]
]

//adjacent// 인접한
func dijkstra(graph: [String: [String: Int]], startNode: String) -> [String: Int] {
    //1. 초기화
    var distances: [String: Int] = [:]
    var priorityQueue = PriorityQueue<(distance: Int, node: String)>(sort:<)
    graph.forEach { distances[$0.key] = Int.max }
    distances[startNode] = 0
    priorityQueue.enqueue((distances[startNode] ?? 0, startNode))
    
    //2. 구현부
    while !priorityQueue.isEmpty {
        let item = priorityQueue.dequeue() ?? (0, "")
        let currentDistance = item.distance
        let currentNode = item.node
        
        if distances[currentNode] ?? 0 < currentDistance { continue }
        
        for (adjacentNode, adjacentDistance) in graph[currentNode] ?? ["":0] {
            let distance = currentDistance + adjacentDistance
            
            if distance < (distances[adjacentNode] ?? 0) {
                distances[adjacentNode] = distance
                priorityQueue.enqueue((distance, adjacentNode))
            }
        }
    }
    
    return distances
}

print("\n===dijkstra===")
let result = dijkstra(graph: graph, startNode: "A").sorted { $0.key < $1.key }
print(result.forEach { print($0) })




