import PropertyWrapper
import XCTest

final class NestedTests: XCTestCase {
    func testDumpNestRedacted() {
        let orderDifferent = OrderDifferent()
        var orderDifferentDump = ""

        dump(orderDifferent, to: &orderDifferentDump)

        XCTAssertEqual(
            orderDifferentDump,
            """
            ▿ PropertyWrapperTests.OrderDifferent
              - _wholeHidden: --redacted--
              ▿ _partialHidden: SwiftUI.State<PropertyWrapperTests.LoggingExcluded<Swift.Int>>
                - _value: --redacted--
                - _location: nil

            """
        )
    }

    func testGetNestedProjectValue() {
        let data = OrderDifferent()
        let wholeBinding: Binding<Int> = data.$wholeHidden
        _ = wholeBinding
        let partialBinding: Binding<LoggingExcluded<Int>> = data.$partialHidden
        _ = partialBinding
    }
}

import SwiftUI


struct OrderDifferent {
    @LoggingExcluding
    @State
    var wholeHidden = 0

    @State
    @LoggingExcluded
    var partialHidden = 0
}

extension State: Projected {}
