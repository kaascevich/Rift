// Protocols.swift
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

/// A type that can be negated with the prefix `!` operator.
public protocol Not {
    static prefix func ! (value: Self) -> bool
}

extension bool: Not { }

/// A type that can be compared for value equality.
///
/// Types that conform to the `PartialEq` protocol can be compared for equality
/// using the equal-to operator (`==`) or inequality using the not-equal-to
/// operator (`!=`). Most basic types in the Swift standard library conform to
/// `PartialEq`.
///
/// Some sequence and collection operations can be used more simply when the
/// elements conform to `PartialEq`. For example, to check whether an array
/// contains a particular value, you can pass the value itself to the
/// `contains(_:)` method when the array's element conforms to `PartialEq`
/// instead of providing a closure that determines equivalence. The following
/// example shows how the `contains(_:)` method can be used with an array of
/// strings.
///
/// ```swift
/// let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
///
/// let nameToCheck = "Kofi"
/// if students.contains(nameToCheck) {
///     print("\(nameToCheck) is signed up!")
/// } else {
///     print("No record of \(nameToCheck).")
/// }
/// // Prints "Kofi is signed up!"
/// ```
///
/// # Conforming to the PartialEq Protocol
///
/// Adding `PartialEq` conformance to your custom types means that you can use
/// more convenient APIs when searching for particular instances in a
/// collection. `PartialEq` is also the base protocol for the `Hashable` and
/// `PartialOrd` protocols, which allow more uses of your custom type, such as
/// constructing sets or sorting the elements of a collection.
///
/// You can rely on automatic synthesis of the `PartialEq` protocol's
/// requirements for a custom type when you declare `PartialEq` conformance in
/// the type's original declaration and your type meets these criteria:
///
/// - For a `struct`, all its stored properties must conform to `PartialEq`.
/// - For an `enum`, all its associated values must conform to `PartialEq`. (An
///   `enum` without associated values has `PartialEq` conformance even
///   without the declaration.)
///
/// To customize your type's `PartialEq` conformance, to adopt `PartialEq` in a
/// type that doesn't meet the criteria listed above, or to extend an existing
/// type to conform to `PartialEq`, implement the equal-to operator (`==`) as
/// a static method of your type. The standard library provides an
/// implementation for the not-equal-to operator (`!=`) for any `PartialEq`
/// type, which calls the custom `==` function and negates its result.
///
/// As an example, consider a `StreetAddress` class that holds the parts of a
/// street address: a house or building number, the street name, and an
/// optional unit number. Here's the initial declaration of the
/// `StreetAddress` type:
///
/// ```swift
/// class StreetAddress {
///     let number: String
///     let street: String
///     let unit: String?
///
///     init(_ number: String, _ street: String, unit: String? = nil) {
///         self.number = number
///         self.street = street
///         self.unit = unit
///     }
/// }
/// ```
///
/// Now suppose you have an array of addresses that you need to check for a
/// particular address. To use the `contains(_:)` method without including a
/// closure in each call, extend the `StreetAddress` type to conform to
/// `PartialEq`.
///
/// ```swift
/// extension StreetAddress: PartialEq {
///     static func == (lhs: StreetAddress, rhs: StreetAddress) -> bool {
///         return
///             lhs.number == rhs.number &&
///             lhs.street == rhs.street &&
///             lhs.unit == rhs.unit
///     }
/// }
/// ```
///
/// The `StreetAddress` type now conforms to `PartialEq`. You can use `==` to
/// check for equality between any two instances or call the
/// `PartialEq`-constrained `contains(_:)` method.
///
/// ```swift
/// let addresses = [StreetAddress("1490", "Grove Street"),
///                  StreetAddress("2119", "Maple Avenue"),
///                  StreetAddress("1400", "16th Street")]
/// let home = StreetAddress("1400", "16th Street")
///
/// print(addresses[0] == home)
/// // Prints "false"
/// print(addresses.contains(home))
/// // Prints "true"
/// ```
///
/// Equality implies substitutability -- any two instances that compare equally
/// can be used interchangeably in any code that depends on their values. To
/// maintain substitutability, the `==` operator should take into account all
/// visible aspects of an `PartialEq` type. Exposing nonvalue aspects of
/// `PartialEq` types other than class identity is discouraged, and any that
/// *are* exposed should be explicitly pointed out in documentation.
///
/// Since equality between instances of `PartialEq` types is an equivalence
/// relation, any of your custom types that conform to `PartialEq` must
/// satisfy three conditions, for any values `a`, `b`, and `c`:
///
/// - `a == a` is always `true` (Reflexivity)
/// - `a == b` implies `b == a` (Symmetry)
/// - `a == b` and `b == c` implies `a == c` (Transitivity)
///
/// Moreover, inequality is the inverse of equality, so any custom
/// implementation of the `!=` operator must guarantee that `a != b` implies
/// `!(a == b)`. The default implementation of the `!=` operator function
/// satisfies this requirement.
///
/// ## Equality is Separate From Identity
///
/// The identity of a class instance is not part of an instance's value.
/// Consider a class called `IntegerRef` that wraps an integer value. Here's
/// the definition for `IntegerRef` and the `==` function that makes it
/// conform to `PartialEq`:
///
/// ```swift
/// class IntegerRef: PartialEq {
///     let value: isize
///     init(_ value: isize) {
///         self.value = value
///     }
///
///     static func == (lhs: IntegerRef, rhs: IntegerRef) -> bool {
///         return lhs.value == rhs.value
///     }
/// }
/// ```
///
/// The implementation of the `==` function returns the same value whether its
/// two arguments are the same instance or are two different instances with
/// the same integer stored in their `value` properties. For example:
///
/// ```swift
/// let a = IntegerRef(100)
/// let b = IntegerRef(100)
///
/// print(a == a, a == b, separator: ", ")
/// // Prints "true, true"
/// ```
///
/// Class instance identity, on the other hand, is compared using the
/// triple-equals identical-to operator (`===`). For example:
///
/// ```swift
/// let c = a
/// print(c === a, c === b, separator: ", ")
/// // Prints "true, false"
/// ```
public typealias PartialEq = Equatable

/// A type that can be compared for value equality.
///
/// Types that conform to the `Eq` protocol can be compared for equality
/// using the equal-to operator (`==`) or inequality using the not-equal-to
/// operator (`!=`). Most basic types in the Swift standard library conform to
/// `Eq`.
///
/// Some sequence and collection operations can be used more simply when the
/// elements conform to `Eq`. For example, to check whether an array contains
/// a particular value, you can pass the value itself to the `contains(_:)`
/// method when the array's element conforms to `Eq` instead of providing a
/// closure that determines equivalence. The following example shows how the
/// `contains(_:)` method can be used with an array of strings.
///
/// ```swift
/// let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
///
/// let nameToCheck = "Kofi"
/// if students.contains(nameToCheck) {
///     print("\(nameToCheck) is signed up!")
/// } else {
///     print("No record of \(nameToCheck).")
/// }
/// // Prints "Kofi is signed up!"
/// ```
///
/// # Conforming to the Eq Protocol
///
/// Adding `Eq` conformance to your custom types means that you can use more
/// convenient APIs when searching for particular instances in a collection.
/// `Eq` is also the base protocol for the `Hashable` and `PartialOrd`
/// protocols, which allow more uses of your custom type, such as constructing
/// sets or sorting the elements of a collection.
///
/// You can rely on automatic synthesis of the `Eq` protocol's requirements
/// for a custom type when you declare `Eq` conformance in the type's original
/// declaration and your type meets these criteria:
///
/// - For a `struct`, all its stored properties must conform to `Eq`.
/// - For an `enum`, all its associated values must conform to `Eq`. (An `enum`
///   without associated values has `Eq` conformance even without the
///   declaration.)
///
/// To customize your type's `Eq` conformance, to adopt `Eq` in a type that
/// doesn't meet the criteria listed above, or to extend an existing type to
/// conform to `Eq`, implement the equal-to operator (`==`) as a static method
/// of your type. The standard library provides an implementation for the
/// not-equal-to operator (`!=`) for any `Eq` type, which calls the custom `==`
/// function and negates its result.
///
/// As an example, consider a `StreetAddress` class that holds the parts of a
/// street address: a house or building number, the street name, and an
/// optional unit number. Here's the initial declaration of the
/// `StreetAddress` type:
///
/// ```swift
/// class StreetAddress {
///     let number: String
///     let street: String
///     let unit: String?
///
///     init(_ number: String, _ street: String, unit: String? = nil) {
///         self.number = number
///         self.street = street
///         self.unit = unit
///     }
/// }
/// ```
///
/// Now suppose you have an array of addresses that you need to check for a
/// particular address. To use the `contains(_:)` method without including a
/// closure in each call, extend the `StreetAddress` type to conform to `Eq`.
///
/// ```swift
/// extension StreetAddress: Eq {
///     static func == (lhs: StreetAddress, rhs: StreetAddress) -> bool {
///         return
///             lhs.number == rhs.number &&
///             lhs.street == rhs.street &&
///             lhs.unit == rhs.unit
///     }
/// }
/// ```
///
/// The `StreetAddress` type now conforms to `Eq`. You can use `==` to
/// check for equality between any two instances or call the `Eq`-constrained
/// `contains(_:)` method.
///
/// ```swift
/// let addresses = [StreetAddress("1490", "Grove Street"),
///                  StreetAddress("2119", "Maple Avenue"),
///                  StreetAddress("1400", "16th Street")]
/// let home = StreetAddress("1400", "16th Street")
///
/// print(addresses[0] == home)
/// // Prints "false"
/// print(addresses.contains(home))
/// // Prints "true"
/// ```
///
/// Equality implies substitutability -- any two instances that compare equally
/// can be used interchangeably in any code that depends on their values. To
/// maintain substitutability, the `==` operator should take into account all
/// visible aspects of an `Eq` type. Exposing nonvalue aspects of `Eq` types
/// other than class identity is discouraged, and any that *are* exposed should
/// be explicitly pointed out in documentation.
///
/// Since equality between instances of `Eq` types is an equivalence relation,
/// any of your custom types that conform to `Eq` must satisfy three conditions,
/// for any values `a`, `b`, and `c`:
///
/// - `a == a` is always `true` (Reflexivity)
/// - `a == b` implies `b == a` (Symmetry)
/// - `a == b` and `b == c` implies `a == c` (Transitivity)
///
/// Moreover, inequality is the inverse of equality, so any custom implementation
/// of the `!=` operator must guarantee that `a != b` implies `!(a == b)`. The
/// default implementation of the `!=` operator function satisfies this
/// requirement.
///
/// ## Equality is Separate From Identity
///
/// The identity of a class instance is not part of an instance's value.
/// Consider a class called `IntegerRef` that wraps an integer value. Here's
/// the definition for `IntegerRef` and the `==` function that makes it
/// conform to `Eq`:
///
/// ```swift
/// class IntegerRef: Eq {
///     let value: isize
///     init(_ value: isize) {
///         self.value = value
///     }
///
///     static func == (lhs: IntegerRef, rhs: IntegerRef) -> bool {
///         return lhs.value == rhs.value
///     }
/// }
/// ```
///
/// The implementation of the `==` function returns the same value whether its
/// two arguments are the same instance or are two different instances with
/// the same integer stored in their `value` properties. For example:
///
/// ```swift
/// let a = IntegerRef(100)
/// let b = IntegerRef(100)
///
/// print(a == a, a == b, separator: ", ")
/// // Prints "true, true"
/// ```
///
/// Class instance identity, on the other hand, is compared using the
/// triple-equals identical-to operator (`===`). For example:
///
/// ```swift
/// let c = a
/// print(c === a, c === b, separator: ", ")
/// // Prints "true, false"
/// ```
public typealias Eq = Equatable

/// A type that can be compared using the relational operators `<`, `<=`, `>=`,
/// and `>`.
///
/// The `PartialOrd` protocol is used for types that have an inherent order,
/// such as numbers and strings. Many types in the standard library already
/// conform to the `PartialOrd` protocol. Add `PartialOrd` conformance to your
/// own custom types when you want to be able to compare instances using
/// relational operators or use standard library methods that are designed for
/// `PartialOrd` types.
///
/// The most familiar use of relational operators is to compare numbers, as in
/// the following example:
///
/// ```swift
/// let currentTemp = 73
///
/// if currentTemp >= 90 {
///     print("It's a scorcher!")
/// } else if currentTemp < 65 {
///     print("Might need a sweater today.")
/// } else {
///     print("Seems like picnic weather!")
/// }
/// // Prints "Seems like picnic weather!"
/// ```
///
/// You can use special versions of some sequence and collection operations
/// when working with a `PartialOrd` type. For example, if your array's
/// elements conform to `PartialOrd`, you can call the `sort()` method without
/// using arguments to sort the elements of your array in ascending order.
///
/// ```swift
/// var measurements = [1.1, 1.5, 2.9, 1.2, 1.5, 1.3, 1.2]
/// measurements.sort()
/// print(measurements)
/// // Prints "[1.1, 1.2, 1.2, 1.3, 1.5, 1.5, 2.9]"
/// ```
///
/// # Conforming to the PartialOrd Protocol
///
/// Types with `PartialOrd` conformance implement the less-than operator (`<`)
/// and the equal-to operator (`==`). These two operations impose a strict
/// total order on the values of a type, in which exactly one of the following
/// must be true for any two values `a` and `b`:
///
/// - `a == b`
/// - `a < b`
/// - `b < a`
///
/// In addition, the following conditions must hold:
///
/// - `a < a` is always `false` (Irreflexivity)
/// - `a < b` implies `!(b < a)` (Asymmetry)
/// - `a < b` and `b < c` implies `a < c` (Transitivity)
///
/// To add `PartialOrd` conformance to your custom types, define the `<` and
/// `==` operators as static methods of your types. The `==` operator is a
/// requirement of the `Eq` protocol, which `PartialOrd` extends -- see that
/// protocol's documentation for more information about equality in Swift.
/// Because default implementations of the remainder of the relational
/// operators are provided by the standard library, you'll be able to use
/// `!=`, `>`, `<=`, and `>=` with instances of your type without any further
/// code.
///
/// As an example, here's an implementation of a `Date` structure that stores
/// the year, month, and day of a date:
///
/// ```swift
/// struct Date {
///     let year: isize
///     let month: isize
///     let day: isize
/// }
/// ```
///
/// To add `PartialOrd` conformance to `Date`, first declare conformance to
/// `PartialOrd` and implement the `<` operator function.
///
/// ```swift
/// extension Date: PartialOrd {
///     static func < (lhs: Date, rhs: Date) -> bool {
///         if lhs.year != rhs.year {
///             return lhs.year < rhs.year
///         } else if lhs.month != rhs.month {
///             return lhs.month < rhs.month
///         } else {
///             return lhs.day < rhs.day
///         }
///     }
/// ```
///
/// This function uses the least specific nonmatching property of the date to
/// determine the result of the comparison. For example, if the two `year`
/// properties are equal but the two `month` properties are not, the date with
/// the lesser value for `month` is the lesser of the two dates.
///
/// Next, implement the `==` operator function, the requirement inherited from
/// the `Eq` protocol.
///
/// ```swift
///     static func == (lhs: Date, rhs: Date) -> bool {
///         return lhs.year == rhs.year && lhs.month == rhs.month
///             && lhs.day == rhs.day
///     }
/// }
/// ```
///
/// Two `Date` instances are equal if each of their corresponding properties are
/// equal.
///
/// Now that `Date` conforms to `PartialOrd`, you can compare instances of the
/// type with any of the relational operators. The following example compares
/// the date of the first moon landing with the release of David Bowie's song
/// "Space Oddity":
///
/// ```swift
/// let spaceOddity = Date(year: 1969, month: 7, day: 11)   // July 11, 1969
/// let moonLanding = Date(year: 1969, month: 7, day: 20)   // July 20, 1969
/// if moonLanding > spaceOddity {
///     print("Major Tom stepped through the door first.")
/// } else {
///     print("David Bowie was following in Neil Armstrong's footsteps.")
/// }
/// // Prints "Major Tom stepped through the door first."
/// ```
///
/// Note that the `>` operator provided by the standard library is used in this
/// example, not the `<` operator implemented above.
///
/// - Note: A conforming type may contain a subset of values which are treated
///   as exceptional -- that is, values that are outside the domain of
///   meaningful arguments for the purposes of the `PartialOrd` protocol. For
///   example, the special "not a number" value for floating-point types
///   (`FloatingPoint.nan`) compares as neither less than, greater than, nor
///   equal to any normal floating-point value. Exceptional values need not
///   take part in the strict total order.
public typealias PartialOrd = Comparable
