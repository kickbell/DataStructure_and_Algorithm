//
//  main.swift
//  Backtracking
//
//  Created by jc.kim on 10/30/22.
//

import Foundation

func isAvailable(_ currentCandidate: [Int],_ column: Int) -> Bool {
    //현재 퀸이 2번째까지 되어있다면 currentCandidate.count 는 2이다.
    //그런데 배열은 0부터 시작하므로 currentRow는 0,1,2해서 3번째 이다.
    //그리고 매개변수로 현재 열(column)이 넘어온다. 그러면 이것을 바탕으로 계산을 할 수 있다.
    let currentRow = currentCandidate.count
    
    for queenRow in 0..<currentRow {
        if currentCandidate[queenRow] == column ||
            abs(currentCandidate[queenRow] - column) == (currentRow - queenRow) {
            return false
        }
    }
    return true
}


func dfs(_ n: Int, _ currentRow: Int, _ currentCandidate: [Int], _ finalResult: [Int] ) {
    var currentCandidate = currentCandidate //현재까지 퀸이 들어간 결과
    var finalResult = finalResult //최종 결과
    
    if currentRow == n { //재귀적으로 사용되므로 종료조건
        finalResult.append(contentsOf: currentCandidate)
        print("n: \(n) -> answer:", finalResult)
        return
    }

    //가로줄을 행(行, row), 세로줄을 열(列, column)
    for column in 0..<n {
        //isAvailable -> Promising
        //현재까지 퀸이 들어간 결과와 현재 열을 넣으면 그걸 기반으로 조건에 부합하는지 체크
        if isAvailable(currentCandidate, column) {
            //여기까지 왔다는 건 조건을 통과했다는 거니까 퀸 후보자 배열에 컬럼을 추가해준다.
            currentCandidate.append(column)
            //그리고 이제 다음행을 봐야겠지? 그래서 재귀적으로 +1 해서 다시 호출한다.
            dfs(n, currentRow + 1, currentCandidate, finalResult)
            /*
             Prunning(가지치기), 이거 재귀라 되게 헷갈린다. 자 봐봐.
             
             자 생각해봐. 저 dfs 함수에서 if currentRow == n {...} 종료조건에도 해당이 되지 않고,
             isAvailable()에도 true가 아니면 어떻게 될까 ?
             
             그럼 그냥 리턴한다. 즉, 항상 저 두 조건이 true 일리가 없지 않나? 그러면 리턴이 되서 아래로 내려간다.
             그러면 여기서 가지치기를 하는 건데, 재귀함수 잖아? 그러면 한뎁스씩 내려갔다가 다시 스택처럼 올라온다.
             
             f(5)->f(4)->f(3)->f(2)->f(1)->f(종료조건:0)
             f(종료조건:0)->f(1)->f(2)->f(3)->f(4)->f(5) 처럼 말이다.
             
             그러면, 저기서는 리턴조건은 최종 조건이 아니라 isAvailable() 일 것이고, 현재의 column이
             currentCandidate 에 적합하지 않으니 다시 돌아가서 다른 후보자를 탐색해야 한다.
             그래서 아래처럼 popLast()를 해주면 조건을 만족하지 않는 곳 까지 쭉쭉 리턴되고, 다음 for문을 돌겠지?
             그러면 다음 녀석이 isAvailable()를 만족하면 이제 다음 currentCandidate 를 탐색하는 식이다.
             
             좀 헷갈릴 수 있다. 아니 지금도 매우 헷갈리다. 이래서 backtracking 이다.
             */
            _ = currentCandidate.popLast()
        }
    }
    
}


func nQueens(_ n: Int) -> [Int] {
    let finalResult: [Int] = []
    dfs(n, 0, [], finalResult)
    return finalResult
}


print("\n===nQueens===")
_ = nQueens(4)

