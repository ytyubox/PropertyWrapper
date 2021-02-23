//
/*
 *		Created by 游宗諭 in 2021/2/20
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

@propertyWrapper struct Lock<Value> {
    private var inner: LockInner

    init(wrappedValue: Value) {
        inner = LockInner(wrappedValue)
    }

    var wrappedValue: Value {
        get { return inner.value }
        nonmutating _modify {
            inner.lock.lock()
            defer { inner.lock.unlock() }
            yield &inner.value
        }
    }

    private class LockInner {
        let lock = NSLock()
        var value: Value

        init(_ value: Value) {
            self.value = value
        }
    }
}

import XCTest
class ThreadSaveTests: XCTestCase {
    @Lock var lockV = 0
    func testLockValue() {
        randomQueueAsync { _ in
            self.lockV += 1
        }
        XCTAssertEqual(lockV, expect)
    }

    @Lock var lockList = [Int]()
    func testLockArray() {
        randomQueueAsync { index in
            self.lockList.append(index)
        }
        XCTAssertEqual(lockList.count, expect)
    }

    @Lock var lockDic = [String: Int]()
    func testLock() {
        randomQueueAsync { index in
            self.lockDic["item-\(index)"] = index
        }
        XCTAssertEqual(lockDic.count, expect)
    }

    @Lock var lockDicWithArray = [String: [Int]]()
    func testLockDicWithArray() {
        let await = expectation(description: #function)
        let total = 100
        let g = DispatchGroup()
        let randomQueue = { DispatchQueue.global() }

        for i in 0 ..< total {
            g.enter()
            randomQueue().async {
                self.lockDicWithArray["item-\(i)"] = []
                for j in 0 ..< total {
                    g.enter()
                    randomQueue().async {
                        self.lockDicWithArray["item-\(i)"]!.append(j)
                        g.leave()
                    }
                }
                g.leave()
            }
        }

        g.notify(queue: .main) {
            await.fulfill()
        }
        wait(for: [await], timeout: 1)
        XCTAssertEqual(lockDicWithArray.count, total)
        XCTAssertTrue(lockDicWithArray.values.allSatisfy{$0.count == total})
    }

    // MARK: - help

    var expect: Int { total }
    let total = 100_000
    func randomQueueAsync(action: @escaping (Int) -> Void) {
        let await = expectation(description: #function)
        let g = DispatchGroup()

        for index in 0 ..< total {
            g.enter()
            DispatchQueue.global().async {
                action(index)
                g.leave()
            }
        }
        g.notify(queue: .main) {
            await.fulfill()
        }
        wait(for: [await], timeout: 1.0)
    }
}

struct LockSample {
    @Lock var i = 0
    func add() {
        i += 1
    }
}
