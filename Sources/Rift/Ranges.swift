// Ranges.swift
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

prefix operator ..
prefix operator ..=
postfix operator ..
infix operator ..: RangeFormationPrecedence
infix operator ..=: RangeFormationPrecedence

public extension Comparable {
    /// Returns a partial range up to, but not including, its upper bound.
    ///
    /// Use the prefix closed range operator (prefix `..`) to create a
    /// partial range of any type that conforms to the `Comparable`
    /// protocol. This example creates a `PartialRangeUp<Double>`
    /// instance that includes any value less than `5.0`.
    ///
    /// ```swift
    /// let throughFive = ..5.0
    ///
    /// throughFive.contains(4.0) // true
    /// throughFive.contains(5.0) // false
    /// throughFive.contains(6.0) // false
    /// ```
    ///
    /// You can use this type of partial range of a collection's indices
    /// to represent the range from the start of the collection up to,
    /// but not including, the partial range's upper bound.
    ///
    /// ```swift
    /// let numbers = [10, 20, 30, 40, 50, 60, 70]
    /// print(numbers[..3])
    /// // Prints "[10, 20, 30]"
    /// ```
    ///
    /// - Precondition: `maximum` must compare equal to itself (i.e.
    ///   cannot be `NaN`).
    ///
    /// - Parameter maximum: The upper bound for the range.
    ///
    /// - Returns: A partial range up to, and including, `maximum`.
    static prefix func .. (maximum: Self) -> PartialRangeUpTo<Self> {
        ..<maximum
    }
    
    /// Returns a partial range up to, and including, its upper bound.
    ///
    /// Use the prefix closed range operator (prefix `..=`) to create a
    /// partial range of any type that conforms to the `Comparable`
    /// protocol. This example creates a `PartialRangeThrough<Double>`
    /// instance that includes any value less than or equal to `5.0`.
    ///
    /// ```swift
    /// let throughFive = ..=5.0
    ///
    /// throughFive.contains(4.0) // true
    /// throughFive.contains(5.0) // true
    /// throughFive.contains(6.0) // false
    /// ```
    ///
    /// You can use this type of partial range of a collection's indices
    /// to represent the range from the start of the collection up to,
    /// and including, the partial range's upper bound.
    ///
    /// ```swift
    /// let numbers = [10, 20, 30, 40, 50, 60, 70]
    /// print(numbers[..=3])
    /// // Prints "[10, 20, 30, 40]"
    /// ```
    ///
    /// - Precondition: `maximum` must compare equal to itself (i.e.
    ///   cannot be `NaN`).
    ///
    /// - Parameter maximum: The upper bound for the range.
    ///
    /// - Returns: A partial range up to, and including, `maximum`.
    static prefix func ..= (maximum: Self) -> PartialRangeThrough<Self> {
        ...maximum
    }
    
    /// Returns a partial range extending upward from a lower bound.
    ///
    /// Use the postfix range operator (postfix `..`) to create a partial
    /// range of any type that conforms to the `Comparable` protocol.
    /// This example creates a `PartialRangeFrom<Double>` instance that
    /// includes any value greater than or equal to `5.0`.
    ///
    /// ```swift
    /// let atLeastFive = 5.0..
    ///
    /// atLeastFive.contains(4.0) // false
    /// atLeastFive.contains(5.0) // true
    /// atLeastFive.contains(6.0) // true
    /// ```
    ///
    /// You can use this type of partial range of a collection's indices
    /// to represent the range from the partial range's lower bound up to
    /// the end of the collection.
    ///
    /// ```swift
    /// let numbers = [10, 20, 30, 40, 50, 60, 70]
    /// print(numbers[3..])
    /// // Prints "[40, 50, 60, 70]"
    /// ```
    ///
    /// - Precondition: `minimum` must compare equal to itself (i.e.
    ///   cannot be `NaN`).
    ///
    /// - Parameter minimum: The lower bound for the range.
    ///
    /// - Returns: A partial range extending upward from `minimum`.
    static postfix func .. (minimum: Self) -> PartialRangeFrom<Self> {
        minimum...
    }
    
    /// Returns a half-open range that contains its lower bound but not
    /// its upper bound.
    ///
    /// Use the half-open range operator (`..`) to create a range of any
    /// type that conforms to the `Comparable` protocol. This example
    /// creates a `Range<Double>` from zero up to, but not including,
    /// `5.0`.
    ///
    /// ```swift
    /// let lessThanFive = 0.0..5.0
    /// print(lessThanFive.contains(3.14)) // Prints "true"
    /// print(lessThanFive.contains(5.0))  // Prints "false"
    /// ```
    ///
    /// - Precondition: `minimum <= maximum`.
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    ///
    /// - Returns: An open range from `minimum` up to, but not including,
    /// `maximum`.
    static func .. (minimum: Self, maximum: Self) -> Range<Self> {
        minimum..<maximum
    }
    
    /// Returns a closed range that contains both of its bounds.
    ///
    /// Use the closed range operator (`..=`) to create a closed range
    /// of any type that conforms to the `Comparable` protocol. This
    /// example creates a `ClosedRange<Character>` from `"a"` up to,
    /// and including, `"z"`.
    ///
    /// ```swift
    /// let lowercase = "a"..="z"
    /// print(lowercase.contains("z"))
    /// // Prints "true"
    /// ```
    ///
    /// - Precondition: `minimum <= maximum`.
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    ///
    /// - Returns: A closed range from `minimum` to `maximum`.
    static func ..= (minimum: Self, maximum: Self) -> ClosedRange<Self> {
        minimum...maximum
    }
}
