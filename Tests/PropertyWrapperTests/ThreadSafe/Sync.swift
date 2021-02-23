//
/*
 *		Created by 游宗諭 in 2021/1/19
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
@propertyWrapper
class Sync<Value> {
    private var value: Value
    private let queue = DispatchQueue(label: "atomic")

    var wrappedValue: Value {
        get { queue.sync { value } }
        set { queue.sync { self.value = newValue } }
    }

    init(wrappedValue value: Value) {
        self.value = value
    }
}

import XCTest
class SyncSaveTests: XCTestCase {
    @Sync var lockSingleValue = 0
    func testLockValue() {
        randomQueueAsync { _ in
            self.lockSingleValue += 1
        }
        XCTAssertLessThan(lockSingleValue, expect)
    }

    @Sync var lockDic = [String: Int]()
    func testLock() {
        randomQueueAsync { index in
            self.lockDic["item-\(index)"] = index
        }
        XCTAssertLessThan(lockDic.count, expect)
    }

    @Sync var lockList = [Int]()
    func testLockArray() {
        randomQueueAsync { index in
            self.lockList.append(index)
        }
        XCTAssertLessThan(lockList.count, expect)
    }

    // MARK: - help

    var expect: Int { total }
    let total = 100 // _000
    func randomQueueAsync(action: @escaping (Int) -> Void) {
        let queue = DispatchQueue(label: "")
        let await = expectation(description: #function)
        let g = DispatchGroup()

        for index in 0 ..< total {
            g.enter()
            DispatchQueue.global().async {
                action(index)
                g.leave()
            }
        }
        g.notify(queue: queue) {
            await.fulfill()
        }
        wait(for: [await], timeout: 1.0)
    }
}
