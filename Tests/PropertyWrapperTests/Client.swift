//
/*
 *		Created by 游宗諭 in 2021/2/22
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 11.2
 */

@propertyWrapper
struct SmallNumber {
    private var number: Int
    var projectedValue: Bool
    init() {
        number = 0
        projectedValue = false
    }

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}

struct SomeStructure {
    @SmallNumber var someNumber: Int
}

let s = [SomeStructure()].map(\.$someNumber)
import XCTest

class KVOTests: XCTestCase {
    class Target: NSObject {
        @SmallNumber @objc dynamic var someNumber
    }

    func test() {
        let target = Target()
        var captured = [Int]()
        let token = target.observe(\.someNumber, options: .new) { _, change in
            captured.append(change.newValue!)
        }
        target.someNumber = 1
        XCTAssertEqual(captured, [1])
        token.invalidate()
    }
}
