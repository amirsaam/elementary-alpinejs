import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class GlobalsTests: XCTestCase {
    func testRegisterData() throws {
        let expected = try String(contentsOf: fixtureURL("register-global-data.html"), encoding: .utf8)
        HTMLAssertEqual(
            registerGlobal(.data, on: "dropdown") { "() => ({ open: false })" },
            expected
        )
    }

    func testRegisterStore() throws {
        let expected = try String(contentsOf: fixtureURL("register-global-store.html"), encoding: .utf8)
        HTMLAssertEqual(
            registerGlobal(.store, on: "notifications") { "{ items: [] }" },
            expected
        )
    }

    func testRegisterBind() throws {
        let expected = try String(contentsOf: fixtureURL("register-global-bind.html"), encoding: .utf8)
        HTMLAssertEqual(
            registerGlobal(.bind, on: "SomeButton") { "() => ({ type: 'button' })" },
            expected
        )
    }

    func testRegisterDataWithSrc() throws {
        let expected = try String(contentsOf: fixtureURL("register-global-data-src.html"), encoding: .utf8)
        HTMLAssertEqual(
            registerGlobal(.data, on: "dropdown", src: "/js/dropdown.js"),
            expected
        )
    }

    func testRegisterEscapesOnWithQuoteAndBackslash() throws {
        let expected = try String(contentsOf: fixtureURL("register-global-escape.html"), encoding: .utf8)
        HTMLAssertEqual(
            registerGlobal(.data, on: "drop'down\\path") { "() => ({ open: false })" },
            expected
        )
    }
}
