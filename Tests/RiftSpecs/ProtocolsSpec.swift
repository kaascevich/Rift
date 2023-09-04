// ProtocolsSpec.swift
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

import Quick
import Nimble
@testable import Rift

final class ProtocolsSpec: QuickSpec {
    override class func spec() {
        describe("the Not protocol") {
            it("is conformed to by Bool") {
                let x: Any = true // we don't need redundant warnings
                expect(x is any Not).to(beTrue())
            }
        }
        
        describe("the PartialEq and Eq protocols") {
            it("is a typealias for Equatable") {
                expect((any Equatable).self == (any PartialEq).self).to(beTrue())
                expect((any Equatable).self == (any Eq).self).to(beTrue())
            }
        }
        
        describe("the PartialOrd protocol") {
            it("is a typealias for Comparable") {
                expect((any Comparable).self == (any PartialOrd).self).to(beTrue())
            }
        }
        
        describe("the Hash protocol") {
            it("is a typealias for Hashable") {
                expect((any Hashable).self == (any Hash).self).to(beTrue())
            }
        }
    }
}
