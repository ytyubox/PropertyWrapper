//
/* 
 *		Created by 游宗諭 in 2021/3/12
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 11.2
 */



import XCTest
@propertyWrapper
struct AWrapper<Value:Projected>:Projected {
    
    typealias Value = Value
    
    typealias ProjectedValue = Value.ProjectedValue
    
    
    var wrappedValue: Value
    internal init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    var projectedValue: Value.ProjectedValue {wrappedValue.projectedValue}
}
import struct SwiftUI.State

final class ALotWrapperTests: XCTestCase {
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
        @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper @AWrapper
    @State
    var i = 0
    func test() {
        XCTAssertEqual(i , 0)
        var typeString = ""
        print(type(of: _i), to: &typeString)
        XCTAssertEqual(typeString,
                       """
            AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<AWrapper<State<Int>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

            """)
        var projectTypeString = ""
        print(type(of: $i), to: &projectTypeString)
        XCTAssertEqual(projectTypeString,
                       """
            Binding<Int>

            """
        )
    }
}


