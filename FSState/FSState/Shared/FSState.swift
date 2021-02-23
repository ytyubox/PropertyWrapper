//
/*
 *		Created by 游宗諭 in 2021/2/20
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */
import SwiftUI

@propertyWrapper
struct FSState<Value>: DynamicProperty {
    @ObservedObject private var box: Inner
    init(wrappedValue: Value) {
        box = Inner(wrappedValue)
    }

    var wrappedValue: Value {
        get { box.value }
        nonmutating set { box.value = newValue }
    }

    var projectedValue: Binding<Value> {
        Binding {
            box.value
        } set: {
            box.value = $0
        }
    }

    private final class Inner: ObservableObject {
        init(_ value: Value) {
            self.value = value
        }

        var value: Value {
            willSet {
                objectWillChange.send()
            }
        }
    }
}
