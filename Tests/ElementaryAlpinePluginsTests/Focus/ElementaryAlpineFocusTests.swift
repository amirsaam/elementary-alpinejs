import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineFocusTests: XCTestCase {
    func testTrap() throws {
        let expected = try String(contentsOf: fixtureURL("focus-trap-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xFocus.trap("open")) {},
            expected
        )
    }

    func testTrapInert() throws {
        let expected = try String(contentsOf: fixtureURL("focus-trap-inert.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xFocus.trap("open", modifiers: [.inert])) {},
            expected
        )
    }

    func testTrapNoscroll() throws {
        let expected = try String(contentsOf: fixtureURL("focus-trap-noscroll.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xFocus.trap("open", modifiers: [.noscroll])) {},
            expected
        )
    }

    func testTrapNoreturn() throws {
        let expected = try String(contentsOf: fixtureURL("focus-trap-noreturn.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xFocus.trap("open", modifiers: [.noreturn])) {},
            expected
        )
    }

    func testTrapNoautofocus() throws {
        let expected = try String(contentsOf: fixtureURL("focus-trap-noautofocus.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xFocus.trap("open", modifiers: [.noautofocus])) {},
            expected
        )
    }

    func testTrapChainedModifiers() throws {
        let expected = try String(contentsOf: fixtureURL("focus-trap-chained.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xFocus.trap("open", modifiers: [.inert, .noscroll, .noreturn])) {},
            expected
        )
    }
}
