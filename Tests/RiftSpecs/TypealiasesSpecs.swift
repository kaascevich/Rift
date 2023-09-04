// TypealiasesSpecs.swift
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

final class TypealiasesSpecs: QuickSpec {
    override class func spec() {
        describe("signed integers") {
            describe("the isize type") {
                it("is a typealias for Int") {
                    let x: isize = 64
                    expect(x).to(beAnInstanceOf(Int.self))
                }
            }
            
            describe("the i8 type") {
                it("is a typealias for Int8") {
                    let x: i8 = 64
                    expect(x).to(beAnInstanceOf(Int8.self))
                }
            }
            
            describe("the i16 type") {
                it("is a typealias for Int16") {
                    let x: i16 = 64
                    expect(x).to(beAnInstanceOf(Int16.self))
                }
            }
            
            describe("the i32 type") {
                it("is a typealias for Int32") {
                    let x: i32 = 64
                    expect(x).to(beAnInstanceOf(Int32.self))
                }
            }
            
            describe("the i64 type") {
                it("is a typealias for Int64") {
                    let x: i64 = 64
                    expect(x).to(beAnInstanceOf(Int64.self))
                }
            }
        }
        
        describe("unsigned integers") {
            describe("the usize type") {
                it("is a typealias for UInt") {
                    let x: usize = 64
                    expect(x).to(beAnInstanceOf(UInt.self))
                }
            }
            
            describe("the u8 type") {
                it("is a typealias for UInt8") {
                    let x: u8 = 64
                    expect(x).to(beAnInstanceOf(UInt8.self))
                }
            }
            
            describe("the u16 type") {
                it("is a typealias for UInt16") {
                    let x: u16 = 64
                    expect(x).to(beAnInstanceOf(UInt16.self))
                }
            }
            
            describe("the u32 type") {
                it("is a typealias for UInt32") {
                    let x: u32 = 64
                    expect(x).to(beAnInstanceOf(UInt32.self))
                }
            }
            
            describe("the u64 type") {
                it("is a typealias for UInt64") {
                    let x: u64 = 64
                    expect(x).to(beAnInstanceOf(UInt64.self))
                }
            }
        }
        
        describe("floats") {
            describe("the f32 type") {
                it("is a typealias for Float") {
                    let x: f32 = 64
                    expect(x).to(beAnInstanceOf(Float.self))
                }
            }
            
            describe("the f64 type") {
                it("is a typealias for Double") {
                    let x: f64 = 64
                    expect(x).to(beAnInstanceOf(Double.self))
                }
            }
        }
        
        describe("other typealiases") {
            describe("the bool type") {
                it("is a typealias for Bool") {
                    let x: bool = true
                    expect(x).to(beAnInstanceOf(Bool.self))
                }
            }
            
            describe("the char type") {
                it("is a typealias for Character") {
                    let x: char = "R"
                    expect(x).to(beAnInstanceOf(Character.self))
                }
            }
        }
    }
}
