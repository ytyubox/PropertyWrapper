//
/*
 *		Created by 游宗諭 in 2021/1/19
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

@propertyWrapper public struct LoggingExcluded<Value>:
    CustomStringConvertible,
    CustomDebugStringConvertible,
    CustomLeafReflectable
{
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public var description: String {
        return "--redacted--"
    }

    public var debugDescription: String {
        return "--redacted--"
    }

    public var customMirror: Mirror {
        return Mirror(reflecting: "--redacted--")
    }
}

@propertyWrapper public struct LoggingExcluding<Value: Projected>: CustomStringConvertible, CustomDebugStringConvertible, CustomLeafReflectable {
    public var wrappedValue: Value
    public var projectedValue: Value.ProjectedValue {
        wrappedValue.projectedValue
    }

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public var description: String {
        return "--redacted--"
    }

    public var debugDescription: String {
        return "--redacted--"
    }

    public var customMirror: Mirror {
        return Mirror(reflecting: "--redacted--")
    }
}
