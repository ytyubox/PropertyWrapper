//
/*
 *		Created by 游宗諭 in 2021/2/23
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

@propertyWrapper
struct AnyProxy<EnclosingType, Value> {
    typealias ValueKeyPath = ReferenceWritableKeyPath<EnclosingType, Value>
    typealias SelfKeyPath = ReferenceWritableKeyPath<EnclosingType, Self>

    static subscript(
        _enclosingInstance instance: EnclosingType,
        wrapped _: ValueKeyPath,
        storage storageKeyPath: SelfKeyPath
    ) -> Value {
        get {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            return instance[keyPath: keyPath]
        }
        set {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            instance[keyPath: keyPath] = newValue
        }
    }

    @available(*, unavailable,
               message: "@Proxy can only be applied to classes")
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    private let keyPath: ValueKeyPath

    init(_ keyPath: ValueKeyPath) {
        self.keyPath = keyPath
    }
}

import Foundation
protocol ProxyContainer {
    typealias Proxy<T> = AnyProxy<Self, T>
}

extension NSObject: ProxyContainer {}

class Label {
    var text: String = ""
}

class Button {
    var data: Data?
}

class HeaderView: NSObject {
    @AnyProxy(\HeaderView.label.text) var title2: String
    @AnyProxy(\HeaderView.button.data) var data2: Data?

    // extension on NSObject
    @Proxy(\.label.text) var title: String
    @Proxy(\.button.data) var data: Data?

    private let label = Label()
    private let button = Button()
}
