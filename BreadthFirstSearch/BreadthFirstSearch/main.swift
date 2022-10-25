//
//  main.swift
//  BreadthFirstSearch
//
//  Created by jc.kim on 10/26/22.
//

import Foundation

/*
 그래프는 아래와 같이 입력
 https://www.fun-coding.org/00_Images/bfsgraph.png
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
 swift에서는 popFirst를 Array에는 없다.
 ArraySlice에만 있기 때문이다.
 그래서 Array에서도 사용하려면, Range<T>를 리턴하는 indices를 사용해서 서브스크립트 문법을 통해 사용한다.
 extension 으로도 만들 수 있다.
 
 ```swift
 //1. ArraySlice 와 서브스크립트를 활용
 var arr = [1,2,3]
 arr[arr.indices].popFirst()
 
 //2. 불편하다면 extension
 extension Array {
     mutating func popFirst() -> Element? {
         return self[self.indices].popFirst()
     }
 }
 
 //3. removeFirst()는 안되나요 ?
 안된다. 빈배열에 removeFirst 를 하면 크래시가 발생하지만,
 빈배열에 popFirst를 하면 nil이 리턴되기 때문에 다르다.
 ```
 */


/*
 ### 큐 2개(visited queue, need_visited queue)를 활용해서 데이터를 넣는 순서
 1. 맨처음 A를 need_visited queue에 넣는다.
 2. need_visited queue에 들어가있는 데이터 중에 맨 앞에있는 데이터를 꺼낸다.( 데이터는 큐에서 없어진다. )
 3. 꺼낸 데이터가 visited queue에 있는지 확인한다.
     - 확인해서 있다면
         1. visited queue에 꺼낸 데이터를 넣는다.
         2. 그리고 visited queue 넣은 데이터의 키값에 해당되는 value를 need_visited queue 에 순서대로 넣는다. 다음턴으로 넘어간다.
     - 확인해서 없다면
         1. 아무것도 하지 않는다. 다음턴으로 넘어간다.
 4. need_visited queue에 들어가있는 데이터 중에 맨 앞에있는 데이터를 꺼낸다.( 데이터는 큐에서 없어진다. )
 5. 꺼낸 데이터가 visited queue에 있는지 확인한다. ( 아래생략 )
 6. need_visited queue에 들어가있는 데이터 중에 맨 앞에있는 데이터를 꺼낸다.( 데이터는 큐에서 없어진다. )
 7. 꺼낸 데이터가 visited queue에 있는지 확인한다. ( 아래생략 )
 ...
 8. 끝날때까지 진행한다.
 9. need_visited queue 이 비게 된다면 그래프를 다 순회한 것이므로 종료한다.

 참고 그래프 이미지
 https://www.fun-coding.org/00_Images/bfsgraph.png
 */


/*
 중요한 포인트가 몇가지 있다.
 1. swift dict는 python처럼 입력순으로 정렬되지 않는다.
 2. 정렬이 필요한가? 필요하다. startNode를 정하기 위해서. 그것 외에는 필요가 없다.
    let startNode = graph.sorted { $0.key < $1.key }.first?.key ?? ""
 3. Array에는 popFirst()가 없기 때문에 ArraySlice를 사용했다.
 4. popFirst()를 하면 마치 디큐처럼 배열에서 첫번째 데이터는 사라지고 사라진 데이터를 리턴한다.
 5. removeFirst()는 사용할 수 없다. 빈배열에서 사용하면 크래시가 발생하기 때문이다 .
 */
func bfs(_ sortedGraph: [String: [String]], _ startNode: String) -> [String] {
    var visitedQueue: [String] = []
    var needVisitedQueue: [String] = []

    needVisitedQueue.append(startNode)
//    var count = 0 //실행횟수, 시간복잗도 확인
    
    while !needVisitedQueue.isEmpty {
//        count += 1
        let node = needVisitedQueue[needVisitedQueue.indices].popFirst() ?? ""
        if !visitedQueue.contains(node) {
            visitedQueue.append(node)
            needVisitedQueue.append(contentsOf: graph[node] ?? [])
        }
    }

//    print("count : \(count)")
    return visitedQueue
}


print(bfs(graph, startNode))
//["A", "B", "C", "D", "G", "H", "I", "E", "F", "J"]
//bfs 의 시간복잡도는 O(V+E)
//V는 노드수, E는 간선수
//따라서 19
//count : 19









