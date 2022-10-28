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


/*
 ### 다익스트라 알고리즘
 - 탐색할 그래프의 시작 정점과 다른 정점들간의 최단 거리 구하기
 */
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
        
        //adjacent 인접한
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



/*
 ### 참고: 최단 경로 출력
 - 탐색할 그래프의 시작 정점과 다른 정점들간의 최단 거리 및 최단 경로 출력하기
 */

//{'A': inf, 'B': inf, 'C': inf, 'D': inf, 'E': inf, 'F': inf} aaa
//{'A': [inf, 'A'], 'B': [inf, 'A'], 'C': [inf, 'A'], 'D': [inf, 'A'], 'E': [inf, 'A'], 'F': [inf, 'A']} aaa


func dijkstra(graph: [String: [String: Int]], startNode: String, endNode: String) -> [String : (distance: Int, node: String)] {
    //1. 초기화
    //위에랑 다른점은 distances의 value값이 Int -> (distance: Int, node: String)로 바뀌면서 초기화 코드가 싹 바뀜.
    var distances: [String: (distance: Int, node: String)] = [:]
    var priorityQueue = PriorityQueue<(distance: Int, node: String)>(sort:<)
    graph.forEach { distances[$0.key] = (Int.max, $0.key) }
    distances[startNode] = (0, startNode)
    priorityQueue.enqueue((distances[startNode]?.distance ?? 0, startNode))
    
    //2. 구현부
    //구현부도 바뀐쪽은 1번과 같음.
    while !priorityQueue.isEmpty {
        let item = priorityQueue.dequeue() ?? (0, "")
        let currentDistance = item.distance
        let currentNode = item.node
        
        if distances[currentNode]?.distance ?? 0 < currentDistance { continue }
        
        //adjacent 인접한
        for (adjacentNode, adjacentDistance) in graph[currentNode] ?? ["":0] {
            let distance = currentDistance + adjacentDistance
            
            if distance < (distances[adjacentNode]?.distance ?? 0) {
                distances[adjacentNode] = (distance, currentNode)
                priorityQueue.enqueue((distance, adjacentNode))
            }
        }
    }
    
    //3. 바뀐 부분을 사용해서 아래와 같이
    //start to end까지 최단 경로를 출력하기 위한 로직이 추가됨.
    var path = endNode
    var pathOutput = endNode + " <- "
    while distances[path]?.node ?? "" != startNode {
        let node = distances[path]?.node ?? ""
        pathOutput += node + " <- "
        path = distances[path]?.node ?? ""
    }
    pathOutput += startNode
    print("1. startNode로 부터 endNode까지의 최단경로")
    print(pathOutput)
    
    return distances
}


print("\n===dijkstra + start to end===")
let result2 = dijkstra(graph: graph, startNode: "A", endNode: "F").sorted { $0.key < $1.key }

print("\n2. startNode로 부터 다른 노드들 사이의 최단거리")
print(result2.forEach { print($0) })




