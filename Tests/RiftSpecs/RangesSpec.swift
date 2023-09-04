// RangesSpec.swift
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

final class RangesSpec: QuickSpec {
    override class func spec() {
        describe("the prefix .. operator") {
            it("has the same meaning as the prefix ... operator") {
                for i in 1...100 {
                    expect((..26).contains(i)).to(equal((...26).contains(i)))
                }
            }
        }
        
        describe("the postfix .. operator") {
            it("has the same meaning as the postfix ... operator") {
                for i in 1...100 {
                    expect((26..).contains(i)).to(equal((26...).contains(i)))
                }
            }
        }
        
        describe("the infix .. operator") {
            it("has the same meaning as the infix ..< operator") {
                for i in 1...100 {
                    expect((26..84).contains(i)).to(equal((26..<84).contains(i)))
                }
            }
        }
        
        describe("the infix ..= operator") {
            it("has the same meaning as the infix ... operator") {
                for i in 1...100 {
                    expect((26..=84).contains(i)).to(equal((26...84).contains(i)))
                }
            }
        }
    }
}
