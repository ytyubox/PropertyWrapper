//
/*
 *		Created by 游宗諭 in 2021/2/23
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

import Foundation
protocol Copyable: AnyObject {
    func copy() -> Self
}

@propertyWrapper
struct CopyOnWrite<Value: Copyable> {
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    private(set) var wrappedValue: Value

    var projectedValue: Value {
        mutating get {
            if !isKnownUniquelyReferenced(&wrappedValue) {
                wrappedValue = wrappedValue.copy()
            }
            return wrappedValue
        }
        set {
            wrappedValue = newValue
        }
    }
}

import XCTest
class CoWTests: XCTestCase {
    struct ToCopy {
        @CopyOnWrite var object = Target()
        class Target: NSObject, NSCopying, Copyable {
            internal init(value: Int = 0) {
                self.value = value
            }

            var value = 0
            func copy(with _: NSZone? = nil) -> Any {
                Target(value: value)
            }

            func copy() -> Self {
                copy(with: nil) as! Self
            }
        }
    }

    func testCopyOnWrite() {
        var toBeCopy = ToCopy()
        var copied = toBeCopy

        XCTAssertTrue(toBeCopy.object === copied.object)

        let object = toBeCopy.$object

        XCTAssertTrue(object === toBeCopy.object, "The Object is still the same")

        let copiedObject = copied.$object

        XCTAssertFalse(copiedObject === toBeCopy.object, "Now is different Object")
        XCTAssertTrue(copiedObject === copied.object, "And it's capture by Copied")
    }
}
