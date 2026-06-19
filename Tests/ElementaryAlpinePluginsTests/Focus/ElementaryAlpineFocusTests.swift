import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineFocusTests: XCTestCase {
    func testTrap() {
        HTMLAttributeAssertEqual(.xFocus.trap("open"), "x-trap", "open")
    }

    func testTrapInert() {
        HTMLAttributeAssertEqual(
            .xFocus.trap("open", modifiers: [.inert]),
            "x-trap.inert",
            "open"
        )
    }

    func testTrapNoscroll() {
        HTMLAttributeAssertEqual(
            .xFocus.trap("open", modifiers: [.noscroll]),
            "x-trap.noscroll",
            "open"
        )
    }

    func testTrapNoreturn() {
        HTMLAttributeAssertEqual(
            .xFocus.trap("open", modifiers: [.noreturn]),
            "x-trap.noreturn",
            "open"
        )
    }

    func testTrapNoautofocus() {
        HTMLAttributeAssertEqual(
            .xFocus.trap("open", modifiers: [.noautofocus]),
            "x-trap.noautofocus",
            "open"
        )
    }

    func testTrapChainedModifiers() {
        HTMLAttributeAssertEqual(
            .xFocus.trap("open", modifiers: [.inert, .noscroll, .noreturn]),
            "x-trap.inert.noscroll.noreturn",
            "open"
        )
    }
}
