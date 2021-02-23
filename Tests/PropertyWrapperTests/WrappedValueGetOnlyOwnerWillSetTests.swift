//
/* 
 *		Created by 游宗諭 in 2021/2/23
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 11.2
 */


import XCTest
@propertyWrapper struct GetOnly {
    var wrappedValue: Int {0}
}
class WrappedValueGetOnlyOwnerWillSetTests: XCTestCase {
    @GetOnly var i
    @GetOnly var i2 {
        willSet {}
    }
    @GetOnly var i3 {
        didSet {}
    }
    @GetOnly var i4 {
        willSet {}
        didSet {}
    }
    
    /**
     //uncomment to see
     func test() {
     i = 1
     i2 = 2
     i3 = 3
     i4 = 4
     }
     */
}
