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
