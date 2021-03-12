//
/*
 *		Created by 游宗諭 in 2021/2/9
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

public protocol Projected {
    associatedtype ProjectedValue
    var projectedValue: ProjectedValue { get }
}

public protocol ProjectedObject {
    associatedtype Value
    associatedtype ProjectedValue
    var projectedValue: ProjectedValue { get }
    static subscript<EnclosingSelf>(
        _enclosingInstance observed: EnclosingSelf,
        wrapped _: ReferenceWritableKeyPath<EnclosingSelf, Self>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {get set}
}

import SwiftUI

extension State: Projected {}

extension LoggingExcluded: Projected
    where Value: Projected
{
    public typealias ProjectedValue = Value.ProjectedValue
    public var projectedValue: Value.ProjectedValue {
        wrappedValue.projectedValue
    }
}
