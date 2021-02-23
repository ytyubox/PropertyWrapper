import XCTest

@propertyWrapper class PlainWrapper {
    init(wrappedValue _: Void) {}

    var wrappedValue: Void { () }
}

@propertyWrapper class ProjectedWrapper {
    init(wrappedValue _: Void) {}

    var wrappedValue: Void { () }
    var projectedValue: ProjectedWrapper { self }
}

@propertyWrapper class OverloadWrapper {
    init(wrappedValue _: Void) {}

    var wrappedValue: Void { () }
    init() {}
}

@propertyWrapper class OverloadWithArgumentWrapper {
    init(wrappedValue _: Void) {}

    var wrappedValue: Void { () }
    init(description _: String) {}
}

@propertyWrapper class WithArgumentWrapper {
    init(wrappedValue _: Void, description _: String) {}

    var wrappedValue: Void { () }
}

@propertyWrapper final class KnowOwener {
    init(wrappedValue: Void) {
        self.wrappedValue = wrappedValue
    }

    var wrappedValue: Void
    var owner: Any?
    static subscript<EnclosingSelf>(
        _enclosingInstance observed: EnclosingSelf,
        wrapped _: ReferenceWritableKeyPath<EnclosingSelf, Void>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, KnowOwener>
    ) -> Void {
        get {
            observed[keyPath: storageKeyPath].owner = observed
            return observed[keyPath: storageKeyPath].wrappedValue
        }
        set {
            observed[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
}

final class HackPropertywrapperTests: XCTestCase {
    @PlainWrapper var plain: Void = ()
    @ProjectedWrapper var projected: Void = ()
    @OverloadWrapper var overload: Void
    @OverloadWithArgumentWrapper(description: "") var overloadWithArgument: Void
    @WithArgumentWrapper(description: "") var withArgument: Void = ()
    @KnowOwener var knowOwner: Void = ()
    var projectedwrapper: ProjectedWrapper { $projected }
    func test() {
        _ = knowOwner
        XCTAssertTrue(_knowOwner.owner is HackPropertywrapperTests)
    }
}
