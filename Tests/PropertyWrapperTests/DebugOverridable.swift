//
/*
 *		Created by 游宗諭 in 2021/2/23
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

@propertyWrapper
struct DebugOverridable<Value> {
    #if DEBUG
        var wrappedValue: Value
    #else
        let wrappedValue: Value
    #endif
}
