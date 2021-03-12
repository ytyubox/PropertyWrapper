//
/* 
 *		Created by 游宗諭 in 2021/3/11
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 11.2
 */


@propertyWrapper struct Fib {
    var wrappedValue: Int
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
        self.projectedValue = TheFib()
    }
    let projectedValue: TheFib
    
}

public class TheFib {
    public var sequence:[Int] = [0,1]
    func fib(_ x: Int) {
           if x > sequence.count{
        fib(x - 1)
           }
       if x == sequence.count{
         let nextValue = sequence[x - 1] + sequence[x - 2]
        sequence.append(nextValue)
       }
        
    }
    public func callAsFunction(_ x: Int) -> Int {
    fib(x)
    return sequence[x]
    }
}


import XCTest

final class ATests: XCTestCase {
    @Fib var index = 5
    func test() {
        XCTAssertEqual($index(index), 5)
        index = 1
        XCTAssertEqual($index(index), 1)
    }
}

