//
/*
 *		Created by 游宗諭 in 2021/2/23
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 11.2
 */

import Combine

class
/*
 uncomment to see unavailable compile message
 struct
 */
WrapperOwner {
    @Published var i = 0
    @YuPublished var i2 = 0
}

@propertyWrapper
struct YuPublished<Value> {
    @available(*, unavailable, message: "@YuPublished is only available on properties of classes")
    var wrappedValue: Value {
        get { fatalError("only works on instance properties of classes") }
        set { fatalError("only works on instance properties of classes") }
    }

    var value: Value
    init(wrappedValue: Value) {
        value = wrappedValue
    }

    static subscript<EnclosingSelf>(
        _enclosingInstance observed: EnclosingSelf,
        wrapped _: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            observed[keyPath: storageKeyPath].value
        }
        set {
            observed[keyPath: storageKeyPath].value = newValue
        }
    }
}
