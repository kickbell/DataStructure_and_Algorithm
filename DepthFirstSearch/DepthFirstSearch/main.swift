//
//  main.swift
//  DepthFirstSearch
//
//  Created by jc.kim on 10/26/22.
//

import Foundation

/*
 그래프는 아래와 같이 입력
 https://www.fun-coding.org/00_Images/dfsgraph.png
 파이썬은 3.6 버전부터 dict가 입력순으로 정렬된다고 한다.
 swift는 정렬되지 않으니 키값을 기준으로 정렬해서 쓰겠다.
 */

var graph: [String: [String]] = [:]

graph["A"] = ["B", "C"]
graph["B"] = ["A", "D"]
graph["C"] = ["A", "G", "H", "I"]
graph["D"] = ["B", "E", "F"]
graph["E"] = ["D"]
graph["F"] = ["D"]
graph["G"] = ["C"]
graph["H"] = ["C"]
graph["I"] = ["C", "J"]
graph["J"] = ["I"]

let startNode = graph.sorted { $0.key < $1.key }.first?.key ?? ""


/*
 ### 큐(visited queue) 와 스택(need_visited stack)를 활용해서 데이터를 넣는 순서
 1. 맨처음 A를 need_visited stack에 넣는다.
 2. need_visited stack에 들어가있는 데이터 중에 마지막에 있는 데이터를 꺼낸다.( 스택이니까. )
 3. 꺼낸 데이터가 visited queue에 있는지 확인한다.
     - 확인해서 있다면
         1. visited queue에 꺼낸 데이터를 넣는다.
         2. 그리고 visited queue 넣은 데이터의 키값에 해당되는 value를 need_visited stack에 넣는다. 다음턴으로 넘어간다.
     - 확인해서 없다면
         1. 아무것도 하지 않는다. 다음턴으로 넘어간다.
 4. need_visited stack에 들어가있는 데이터 중에 마지막에 있는 데이터를 꺼낸다.( 스택이니까. )
 5. 꺼낸 데이터가 visited queue에 있는지 확인한다. ( 아래생략 )
 6. need_visited stack에 들어가있는 데이터 중에 마지막에 있는 데이터를 꺼낸다.( 스택이니까. )
 7. 꺼낸 데이터가 visited queue에 있는지 확인한다. ( 아래생략 )
 ...
 8. 끝날때까지 진행한다.
 9. need_visited stack 이 비게 된다면 그래프를 다 순회한 것이므로 종료한다.

 참고 그래프 이미지
 https://www.fun-coding.org/00_Images/dfsgraph.png
 */


/*
 중요한 포인트가 몇가지 있다.
 1. swift dict는 python처럼 입력순으로 정렬되지 않는다.
 2. 정렬이 필요한가? 필요하다. startNode를 정하기 위해서. 그것 외에는 필요가 없다.
    let startNode = graph.sorted { $0.key < $1.key }.first?.key ?? ""
 3. 그림과는 다른 결과값이 나왔는데, 방향의 문제이지 dfs의 정책을 위반하지 않는다.
    무슨 말이냐면 그림은 왼쪽부터 돌아서 ABDEFCGHIJ 순이지만 우리 결과값은 ACIJHGBDFE 이다.
    이것은 오른쪽 먼저하냐 왼쪽먼저 하냐의 방향의 차이니까 dfs의 정책을 무시한 것이 아니다.
    그렇다면 데이터가 들어가 있는 value의 순서는 상관이 없나? 그건 아닌 것 같은데?
 */
func dfs(_ sortedGraph: [String: [String]], _ startNode: String) -> [String] {
    var visitedQueue: [String] = []
    var needVisitedStack: [String] = []

    needVisitedStack.append(startNode)
//    var count = 0 //실행횟수, 시간복잗도 확인
    
    while !needVisitedStack.isEmpty {
//        count += 1
        let node = needVisitedStack.popLast() ?? ""
        if !visitedQueue.contains(node) {
            visitedQueue.append(node)
            needVisitedStack.append(contentsOf: graph[node] ?? [])
        }
    }

//    print("count : \(count)")
    return visitedQueue
}


print(dfs(graph, startNode))
//["A", "C", "I", "J", "H", "G", "B", "D", "F", "E"]
//bfs 의 시간복잡도는 O(V+E)
//V는 노드수, E는 간선수
//따라서 19
//count : 19










