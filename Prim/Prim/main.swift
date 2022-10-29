//
//  main.swift
//  Prim
//
//  Created by jc.kim on 10/30/22.
//

import Foundation

/*
 그래프는 아래의 링크 그래프를 예시로 작성한다.
 https://velog.velcdn.com/images/dev_kickbell/post/745e799d-2fcd-4c01-a617-e4e788fd369e/image.png
 */

let edges = [
    (7, "A", "B"), (5, "A", "D"),
    (8, "B", "C"), (9, "B", "D"), (7, "B", "E"),
    (5, "C", "E"),
    (7, "D", "E"), (6, "D", "F"),
    (8, "E", "F"), (9, "E", "G"),
    (11, "F", "G")
]

typealias Edge = (weight: Int, fromNode: String, toNode: String)

func prim(_ startNode: String, _ edges: [Edge]) -> [Edge] {
    var mst: [Edge] = []
    var adjacentEdges: [String: [Edge]] = [:]
    
    //1. 초기화
    //이유는 모르겠지만, adjacentEdges[edge.toNode]?.append(edge)가 안되서 두개로 나누었다.
    //밑에 for문도 튜플이 아니라 edge로 바꾸면 오동작하는데 이유를 모르겠네 진짜로..
    for (_, n1, n2) in edges {
        adjacentEdges[n1] = []
        adjacentEdges[n2] = []
    }
    for (weight, n1, n2) in edges {
        adjacentEdges[n1]?.append((weight, n1, n2))
        adjacentEdges[n2]?.append((weight, n2, n1))
    }
    
    //2. 연결된 노드 리스트 생성
    var connectedNodes: Set = [startNode]
    
    //3. 간선 리스트 생성
    var candidateEdges: [Edge] = adjacentEdges[startNode] ?? []
    
    
    while !candidateEdges.isEmpty {
        //강의에서는 candidateEdges가 힙구조가 되어서 바로 제일 작은걸 꺼내왔지만,
        //swift에서는 그런 라이브러리를 아직 못찾아서 일단 sorted를 사용.
        //빈배열에서 removeFirst()를 하면 크래쉬가 발생하지만, while구문에서 통과되지 않을 것이므로 고고함.
        candidateEdges.sort(by: { $0.weight < $1.weight })
        let poppedEdge = candidateEdges.removeFirst()
        
        if !connectedNodes.contains(poppedEdge.toNode) { //싸이클이 없는 경우
            connectedNodes.insert(poppedEdge.toNode) //연결된 노드 리스트에 추가
            mst.append(poppedEdge) //결과값인 최소 신장 트리에도 추가
            
            //A->D라고 치면 D를 연결된 노드 리스트에 넣어줬고, 이제 D에 연결된 간선들을
            //간선 리스트에 넣어줘야 한다. 여기가 그 작업이다.
            for newEdge in adjacentEdges[poppedEdge.toNode] ?? [] {
                /*
                 여기의 if문은 무슨 뜻이냐면,
                 음, 예를들어
                   A
                  / \
                 B   E-F 가 있다고 치자. 근데 F가 이제 싸이클이 없어서 연결된 노드 리스트에 넣고
                 
                 간선 리스트에 F와 연결된 간선들을 넣으려고 하는 상황인거야. 근데 F를 보니 아래와 같이 생긴거지.
                   F
                  /|\
                 B H G  이래버리면 이중에 B는 어차피 넣을 필요가 없어. 왜? 연결된 노드 리스트에 이미 있으니까.
                 이 상황에서는 H, G만 넣으면 되는거지. B를 굳이 넣어서 괜히 연산을 더 할필요가 없는 것.
                 */
                if !connectedNodes.contains(newEdge.toNode) {
                    candidateEdges.append(newEdge)
                }
            }
        }
    }
    return mst
}

print("\n===prim=== ")
prim("A", edges).forEach { print($0) }

/*
 강사님 결과값이랑 약간 다른데, (7, 'B', 'E') 이부분이 다름.
 근데 그래프 그려보면 어차피 7로 같아서 로직은 맞는 것 같다.
 그냥 최소 신장 트리인데 여러 개중에 하나로 그려진 듯..?
 
 [(5, 'A', 'D'),
  (6, 'D', 'F'),
  (7, 'A', 'B'),
  (7, 'B', 'E'),
  (5, 'E', 'C'),
  (9, 'E', 'G')]
 */


/*
 개선된 프림 알고리즘
 - 간선이 아니라 노드를 기준으로 하기 때문에 시간복잡도가 𝑂(𝐸𝑙𝑜𝑔𝑉) 로 줄어든다.
 
 from heapdict import heapdict

 def prim(graph, start):
     mst, keys, pi, total_weight = list(), heapdict(), dict(), 0
     for node in graph.keys():
         keys[node] = float('inf')
         pi[node] = None
     keys[start], pi[start] = 0, start

     while keys:
         current_node, current_key = keys.popitem()
         mst.append([pi[current_node], current_node, current_key])
         total_weight += current_key
         for adjacent, weight in mygraph[current_node].items():
             if adjacent in keys and weight < keys[adjacent]:
                 keys[adjacent] = weight
                 pi[adjacent] = current_node
     return mst, total_weight
 
 
 
 mygraph = {
     'A': {'B': 7, 'D': 5},
     'B': {'A': 7, 'D': 9, 'C': 8, 'E': 7},
     'C': {'B': 8, 'E': 5},
     'D': {'A': 5, 'B': 9, 'E': 7, 'F': 6},
     'E': {'B': 7, 'C': 5, 'D': 7, 'F': 8, 'G': 9},
     'F': {'D': 6, 'E': 8, 'G': 11},
     'G': {'E': 9, 'F': 11}
 }
 mst, total_weight = prim(mygraph, 'A')
 print ('MST:', mst)
 print ('Total Weight:', total_weight)
 */


