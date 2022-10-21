//
//  main.swift
//  DynamicProgramming
//
//  Created by jc.kim on 10/21/22.
//

import Foundation


func processTime(closure: () -> ()){
    let start = CFAbsoluteTimeGetCurrent()
    closure()
    let processTime = CFAbsoluteTimeGetCurrent() - start
    print("경과 시간: \(processTime)\n")
}


/*
 Dynamic Programming(동적계획법)
 
 코드로 보는게 제일 편하지 싶다. 그래도 정의를 정리하자면,
 어떤 문제가 있을 때 작은 부분으로 잘개 쪼개서 그 답을 상위 문제를 해결하는데 재사용한다는 것이다.
 Memoization 기법을 사용하는데 이 말의 뜻은 부분 문제의 해답을 저장해서 재활용하는 최적화 기법이라는 뜻이다.
 코드가 더 이해가 쉽다. 코드로 보자.
 */



/*
 피보나치 수열(Fibonacci numbers)
 - 첫째 및 둘째 항이 1이며 그 뒤의 모든 항은 바로 앞 두 항의 합인 수열
 - 즉 F0: 0, F1: 1, Fn: Fn-1 + Fn-2 이다.
 
 이걸 재귀(recursive)로 푼다면 공식대로 하면 아래와 같다.
 */

func fibonacci_recursive(_ num: Int) -> Int {
    if num <= 1 { return num }
    return fibonacci_recursive(num - 1) + fibonacci_recursive(num - 2)
}

/*
 근데 여기서 재귀를 사용하면 문제점이 있다.
 
 fibonacci_recursive(4)를 예시로 들어보자. 공식대로 하면 fibonacci(4)는 아래와 같아진다.
 
                                fibonacci(4)

                        fibonacci(2) + fibonacci(3)
    
        fibonacci(1) + fibonacci(0)        fibonacci(2) + fibonacci(1)
 
                                    fibonacci(1) + fibonacci(0)
 
 즉, f(4)를 구하기 위해 f(3)를 1번 계산하고 , f(2)를 2번 계산하며, f(1)은 3번계산하고, f(0)도 2번 계산한다.
 작은 계산이 계속 중복이 된다는 것이다.
 재귀는 스택구조와 유사하니 스택처럼 주루룩 쌓였다가 다시 주루룩 해결되면서 내려올거다.
 이런 중복된 계산을 없애고자 하는게 DP 알고리즘 이다. 이걸 DP로 해결해보자.
 */



func fibonacci_dp(_ num: Int) -> Int {
    if num <= 1 { return num } //여기는 공식대로 똑같다.
    
    //1. 먼저 num의 크기만큼의 0이라는 값을 넣은 배열을 만든다.
    var cache = (0...num).map { _ in 0 }
    cache[0] = 0 //2. 그리고 공식대로 0번쨰와 1번째에는 0과 1을 넣어준다.
    cache[1] = 1 //그러면 이런식으로 되겠지. [0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
    
    //3. 그리고 2번째부터 num까지 for문을 돌아주는데, 중요한 건 공식대로 cache[index]에 값을 계산해서 넣어준다.
    //그리고 핵심이 배열에 계산한 값이 저장되어 있을거아니냐? 그럼 그걸 그대로 그냥 꺼내온다. O(1)로 말이다.
    //그리고 그걸 더해줘서 새로운 index에 넣어주는 것이다. 즉, 이미 저장된 작은 값을 다음 계산에 활용해주고 있다.
    for index in 2...num {
        cache[index] = cache[index - 1] + cache[index - 2]
    }
    
    //4. for문의 순회가 끝났다면 자연스럽게 마지막 cache[num]에는 cache[num - 1] + cache[num - 2]
    //값이 들어가 있을 것이다. 그럼 그냥 그걸 리턴해주면 된다.
    return cache[num]
}

//print(fibonacci_dp(0))
//print(fibonacci_dp(1))
//print(fibonacci_dp(2))
//print(fibonacci_dp(3))
//print(fibonacci_dp(4))
//print(fibonacci_dp(5))
//print(fibonacci_dp(6))
//print(fibonacci_dp(7))
//print(fibonacci_dp(8))
//print(fibonacci_dp(9))






