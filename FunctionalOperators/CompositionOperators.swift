infix operator &&&: LogicalConjunctionPrecedence
infix operator &&~: LogicalConjunctionPrecedence

public func &&&<T>(lhs: @escaping (T) -> T,
                   rhs: @escaping (T) -> T) -> (T) -> T {
    return { rhs(lhs($0)) }
}

public func &&~<T>(lhs: @escaping (T) -> Bool,
                   rhs: @escaping (T) -> Bool) -> (T) -> Bool {
    return { lhs($0) && rhs($0) }
}
