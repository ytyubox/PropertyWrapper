//
/*
 *		Created by 游宗諭 in 2021/2/9
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

import SwiftUI

@propertyWrapper
struct YuState<Value>: DynamicProperty {
    var projectedValue: YuBinding<Value> {
        YuBinding {
            wrappedValue
        } setter: { newValue in
            inner.value = newValue
        }
    }

    var inner: Inner<Value>
    var wrappedValue: Value {
        get {
            inner.value
        }
        set {
            inner.value = newValue
            update()
        }
    }

    init(wrappedValue: Value) {
        inner = Inner(wrappedValue)
    }

    class Inner<Value>: DynamicProperty, ObservableObject {
        internal init(_ value: Value) {
            self.value = value
        }

        var value: Value {
            willSet {
                objectWillChange.send()
            }
        }
    }
}

struct YuBinding<Value> {
    let getter: () -> Value
    let setter: (Value) -> Void
    init(getter: @escaping () -> Value, setter: @escaping (Value) -> Void) {
        self.getter = getter
        self.setter = setter
    }
}
