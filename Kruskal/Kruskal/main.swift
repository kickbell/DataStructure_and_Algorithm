//
//  main.swift
//  Kruskal
//
//  Created by jc.kim on 10/29/22.
//

import Foundation

func processTime(closure: () -> ()){
    let start = CFAbsoluteTimeGetCurrent()
    closure()
    let processTime = CFAbsoluteTimeGetCurrent() - start
    print("경과 시간: \(processTime)\n")
}

/*
 그래프는 아래의 링크 그래프를 예시로 작성한다.
 https://velog.velcdn.com/images/dev_kickbell/post/745e799d-2fcd-4c01-a617-e4e788fd369e/image.png
 */


let graph: [String: Any] = [
    "nodes": ["A", "B", "C", "D", "E", "F", "G"],
    "edges": [
        (7, "A", "B"), //노드의 앞 뒤 순서도 중요
        (5, "A", "D"),
        (7, "B", "A"),
        (8, "B", "C"),
        (9, "B", "D"),
        (7, "B", "E"),
        (8, "C", "B"),
        (5, "C", "E"),
        (5, "D", "A"),
        (9, "D", "B"),
        (7, "D", "E"),
        (6, "D", "F"),
        (7, "E", "B"),
        (5, "E", "C"),
        (7, "E", "D"),
        (8, "E", "F"),
        (9, "E", "G"),
        (6, "F", "D"),
        (8, "F", "E"),
        (11, "F", "G"),
        (9, "G", "E"),
        (11, "G", "F")
    ]
]

typealias Edge = (weight: Int, fromNode: String, toNode: String)

var parent: [String : String] = [:] //노드 : 루트노드 을 리턴해주는 딕셔너리
var rank: [String : Int] = [:] //노드 : 랭크값 을 리턴해주는 딕셔너리

//1. 초기화(Union Find 알고리즘)
func makeSet(_ node: String) {
    parent[node] = node
    rank[node] = 0
}

//2. Union((Union Find 알고리즘))
func union(_ fromNode: String,_ toNode: String) {
    /*
     union-by-rank 기법
     */
    let root1 = find(fromNode) //각 루트 노드를 가져오기
    let root2 = find(toNode)
    
    if rank[root1] ?? 0 > rank[root2] ?? 0 {
        //높이가 작은 트리를 높이가 큰 루트 노드에 자식으로 붙임
        parent[root2] = root1
    } else if rank[root1] ?? 0 < rank[root2] ?? 0 {
        //높이가 작은 트리를 높이가 큰 루트 노드에 자식으로 붙임
        parent[root1] = root2
    } else {
        //랭크 값이 같다면 둘 중 하나 골라서 랭크값을 높이고 자식 노드로 붙임
        //여기서는 root2의 랭크값을 높였으므로 root1을 root2로 붙였음
        if rank[root1] ?? 0 == rank[root2] ?? 0 {
            let num = rank[root2] ?? 0
            rank[root2] = num + 1
        }
        
        parent[root1] = root2
    }
}

//3. Find(Union Find 알고리즘)
func find(_ node: String) -> String {
    /*
     path compression 기법
     
     이게 좀 헷갈릴 수 있다. 근데 잘 들어봐.
     밑에 debug 함수 만들어놨으니 그거 보면 더 쉽다.
     일단 초기화를 해. 그러면 parent는 이렇게 되겠지 ? A:A, B:B, C:C, D:D, E:E, F:F
     그런 상태에서 데이터가 가중치별로 정렬이 되어있어.
     
     (weight: 5, fromNode: "A", toNode: "D"),
     (weight: 5, fromNode: "C", toNode: "E"),
     (weight: 5, fromNode: "D", toNode: "A"),
     (weight: 5, fromNode: "E", toNode: "C"),
     (weight: 6, fromNode: "D", toNode: "F"),
     (weight: 6, fromNode: "F", toNode: "D"),
     (weight: 7, fromNode: "A", toNode: "B"),
     (weight: 7, fromNode: "B", toNode: "A"),
     (weight: 7, fromNode: "B", toNode: "E")...
     
     ---0 count (weight: 5, fromNode: "A", toNode: "D")---
     
     그리고 아래 코드로 싸이클 여부를 판단해.
     
     if find(fromNode) != find(toNode) { ... }
     
     parent 에 지금 아무 것도 안해줬으니 parent["A"] = "A"이고, "D"도 "D"겠지.
     그러면 아래 코드에 따라서, parent[node] = find(parent[node] ?? "") 를 한번 더 타고
     parent에 해준게 없으니 리턴은 parent[node] ?? "" 가 되는거야. 뭐 한게 없지?
     
     근데 그러고 다음 코드로 가보자.
     
     저 메인 코드의 union(fromNode, toNode) 이야.
     
     결론적으로 말하면 둘 다 rank가 같으니 toNode의 rank가 +1이 되고,
     (A:chile) - (D:root)로 연결이 될거야.
     
     그리고 parent는 A:D, B:B, C:C, D:D, E:E, F:F로 변하는거지.
     
     ---1 count (weight: 5, fromNode: "C", toNode: "E")---

     그리고 다음 C,E를 넣으면 마찬가지로 (C:chile) - (E:root)
     
     여기까지 하면 아래와 같이 되겠지.
     parent A:D, B:B, C:E, D:D, E:E, F:F
     rank   A:0, B:0, C:0, D:1, E:1, F:0
     
     ---2 count (weight: 5, fromNode: "D", toNode: "A")---
     ---3 count (weight: 5, fromNode: "E", toNode: "C")---

     그리고 D, A를 넣었다.
     find(D), find(A) 둘 다 루트가 D네? 그럼 얘네는 같은 부분집합(싸이클)에 속해있다고 보면 돼.
     그러면 find(fromNode) != find(toNode) 이 아니므로 그냥 다음 for문으로 넘어가.
     
     E,C 도 마찬가지.
     
     ---4 count (weight: 6, fromNode: "D", toNode: "F")---

     D의 루트노드는 D, F는 F로 달라. 그러면 싸이클이 아니겠고
     rank 값은 D가 1, F가 0이네 그러면 F가 D 밑으로 들어가야돼. 그러면 현재까지는 이렇게 되는거지
     
        D   E
      / |   |
     A  F   C

     parent A:D, B:B, C:E, D:D, E:E, F:D
     rank   A:0, B:0, C:0, D:1, E:1, F:0
     
     ---5 count (weight: 6, fromNode: "F", toNode: "D")---

     이러면, F의 루트는 D, D의 루트도 D니까 싸이클이네. 넘어가.
     
     ---6 count (weight: 7, fromNode: "A", toNode: "B")---

     A의 루트는 D, B의 루트는 B네. 싸이클이 아니야. union 해야해.
     중요한건 여기서 rank를 따져야되는데 if rank[root1] ?? 0 > rank[root2] ?? 0 {...} 로직이므로
     루트
     A는 루트인 D의 랭크를 봐야해서 rank는 1, B는 0이야. 그러면 작은애가 큰애 밑으로 들어가야하니. 트리가 이렇게 돼.
     
        D     E
      / | \   |
     A  F  B  C
     
     그리고 B의 루트를 D로 바꿔줘. path compression 기법.
     
     ---7 count (weight: 7, fromNode: "B", toNode: "A")---

     같은 방식으로 B의 루트는 D, A의 루트도 D 무시
     
     ---8 count (weight: 7, fromNode: "B", toNode: "E")---
     
     같은 방식으로 B의 루트는 D, E의 루트는 E야 싸이클이 없네. union 해야해.
     rank를 보는데 B는 D기준이니 1, E는 E인데 E도 랭크가 1이네?
     그러면 둘 중 아무거나 하나 골라서 랭크를 +1 해주고 자식 노드로 들어가야되는데
     우리는 코드에서 toNode가 올라가게 작성했으니까 E의 rank를 +1하고 D 의 트리를 E로 붙여줘 아래처럼.

            E
           /|
          / C
         /
        D
      / | \
     A  F  B
     
     ... 이런식으로 쭉 하면 결국엔 아래와 같은 트리가 완성되고 그게 최소 신장 트리야.

            E
           /|\
          / C G
         /
        D
      / | \
     A  F  B
    */
    if parent[node] != node {
        parent[node] = find(parent[node] ?? "")
    }
    return parent[node] ?? ""
}

/*
 이걸 swift 내장함수 sorted 대신에 써봤는데 오히려 sorted가 시간이 덜걸리더라.
 내부가 quickSort로 되어있던가? 아니면 더 좋은걸로 되어있나보다.
 */
//func quickSortWithEdge(_ edges: [Edge]) -> [Edge] {
//    if edges.count <= 1 { return edges }
//
//    let pivot: Edge = (edges.first?.weight ?? 0,
//                       edges.first?.fromNode ?? "",
//                       edges.first?.toNode ?? "")
//    let left = edges[1...].filter { pivot.weight > $0.weight }
//    let right = edges[1...].filter { pivot.weight <= $0.weight }
//
//    return quickSortWithEdge(left) + [pivot] + quickSortWithEdge(right)
//}

func kruskal(_ graph: [String: Any]) -> [Edge] {
    var mst: [Edge] = []
    
    //1. 초기화
    guard let nodes = graph["nodes"] as? [String] else { return []}
    for node in nodes {
        makeSet(node)
    }
    
    //2. 간선 weight 기반 sorting ( 이 부분의 sortting은 quicksort를 쓰는게 더 좋지 )
    guard let edges = graph["edges"] as? [Edge] else { return []}
    let sortedEdges = edges.sorted { $0.weight < $1.weight }
//    let sortedEdges = quickSortWithEdge(edges)

    //3. 싸이클이 없는 간선만 연결
    for (index, edge) in sortedEdges.enumerated() {
        let fromNode = edge.fromNode
        let toNode = edge.toNode

        if find(fromNode) != find(toNode) { //싸이클이 없는 걸 이 코드만으로 판별
            union(fromNode, toNode)
            mst.append(edge)
        }
        
        //debug(index, edge) //debug 용도 함수
    }
    return mst
}

print("\n===kruskal===")
//processTime {
    kruskal(graph).sorted { $0.weight < $1.weight }.forEach { print($0) }
//}


func debug(_ index: Int, _ edge: Edge) {
    print("\n---\(index) count \(edge)---")
    print(parent.sorted { $0.key < $1.key }.forEach { print($0)})
    print(rank.sorted { $0.key < $1.key }.forEach { print($0)})
}
