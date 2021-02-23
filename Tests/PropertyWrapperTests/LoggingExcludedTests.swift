//
/*
 *		Created by 游宗諭 in 2021/2/23
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

import XCTest
class Object {
    @LoggingExcluded
    var i = 0
}

class LogExcludeTests: XCTestCase {
    func testDumpRedacted() throws {
        let obj = Object()
        var objDump = ""

        dump(obj, to: &objDump)

        XCTAssertEqual(
            objDump,
            """
            ▿ PropertyWrapperTests.Object #0
              - _i: --redacted--

            """
        )
    }
}
