// Match.swift
// Copyright © 2023 Kaleb A. Ascevich
//
// This package is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This package is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this package. If not, see https://www.gnu.org/licenses/.

public func match<T, Value>(
    _ value: T,
    @MatchBuilder _ arms: () -> [MatchArm<T, Value>]
) -> Value? {
    for arm in arms() {
        if let result = arm.evaluate(with: value) {
            return result
        }
    }
    return nil
}

@resultBuilder public enum MatchBuilder {
    public static func buildBlock<T, Value>(_ arms: MatchArm<T, Value>...) -> [MatchArm<T, Value>] {
        arms
    }
}

precedencegroup MatchArmPrecedence {
    lowerThan: AssignmentPrecedence
}
infix operator =>: MatchArmPrecedence

public struct MatchArm<T, Value> {
    let pattern: (T) -> Bool
    let value: () -> Value
    
    internal init(pattern: @escaping (T) -> Bool, value: @escaping () -> Value) {
        self.pattern = pattern
        self.value = value
    }
    
    internal func evaluate(with value: T) -> Value? {
        if pattern(value) {
            self.value()
        } else { nil }
    }
}

public func => <T, Value>(
    pattern: @escaping (T) -> Bool,
    value: @escaping () -> Value
) -> MatchArm<T, Value> {
    .init(pattern: pattern, value: value)
}

public func => <T, Value>(
    pattern: @escaping (T) -> Bool,
    value: @autoclosure @escaping () -> Value
) -> MatchArm<T, Value> {
    .init(pattern: pattern, value: value)
}

public func => <T: Equatable, Value>(
    pattern: @autoclosure @escaping () -> T,
    value: @escaping () -> Value
) -> MatchArm<T, Value> {
    .init(pattern: { pattern() == $0 }, value: value)
}

public func => <T: Equatable, Value>(
    pattern: @autoclosure @escaping () -> T,
    value: @autoclosure @escaping () -> Value
) -> MatchArm<T, Value> {
    .init(pattern: { pattern() == $0 }, value: value)
}
