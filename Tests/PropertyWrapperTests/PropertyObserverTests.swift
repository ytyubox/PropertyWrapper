//
/* 
 *		Created by 游宗諭 in 2021/2/23
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 11.2
 */


import XCTest
@propertyWrapper struct Wrapper {
    var wrappedValue: Int
    var anotherValue = 0
}
class ProperyObserverTests: XCTestCase {
    @Wrapper var i = 0 {
        willSet {
            captured.append(.willSet(newValue))
        }
        didSet {
            captured.append(.didSet(i))
        }
    }
    var captured = [Setting]()
    func test() {
        XCTAssertTrue(captured.isEmpty)
        _i.anotherValue = 1
        XCTAssertEqual(captured, [])
        _i.wrappedValue = 1
        XCTAssertEqual(captured, [])
        i = 1
        XCTAssertEqual(captured, [.willSet(1), .didSet(1)])
    }
    func testInStruct() {
        var owner = Owner()
        owner._addAnother()
        XCTAssertEqual(owner.captured, [])
        owner._addWrapped()
        XCTAssertEqual(owner.captured, [])
        owner.i = 1
        XCTAssertEqual(owner.captured, [.willSet(1), .didSet(1)])
    }
}

enum Setting:Equatable {
    case didSet(Int), willSet(Int)
}
struct Owner {
    @Wrapper var i = 0 {
        willSet {
            captured.append(.willSet(newValue))
        }
        didSet {
            captured.append(.didSet(i))
        }
    }
    var captured = [Setting]()
    mutating func _addAnother() {
        _i.anotherValue += 1
    }
    mutating func _addWrapped() {
        _i.wrappedValue += 1
    }
    
}
