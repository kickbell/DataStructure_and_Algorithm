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
     이게 왜 되는거냐면, 일단 초기화 메서드인 makeSet으로 초기화가 싹 되어있어.
     A:A, B:B, C:C, D:D, E:E, F:F 같은 식이지. 어차피 노드가 하나니까 노드 == 루트노드
     (root: A)-(B)-(C)-(D) 를 (root: A)-(B,C,D)로 만들거다.
     
     (7, "A", "B"), //노드의 앞 뒤 순서도 중요
     (5, "A", "D"),
     
     
    */
    if parent[node] != node {
        parent[node] = find(parent[node] ?? "")
    }
    return parent[node] ?? ""
}

/*
 이걸 sorted 대신에 써봤는데 오히려 sorted가 시간이 덜걸리더라.
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
    for edge in sortedEdges {
        let fromNode = edge.fromNode
        let toNode = edge.toNode

        if find(fromNode) != find(toNode) {
            union(fromNode, toNode)
            mst.append(edge)
        }
    }
    return mst
}

print("\n===kruskal===")
//processTime {
    kruskal(graph).sorted { $0.weight < $1.weight }.forEach { print($0) }
//}


