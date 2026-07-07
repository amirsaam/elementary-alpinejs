import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineMaskTests: XCTestCase {
    func testPattern() throws {
        HTMLAssertEqual(input(.xMask.pattern("99/99/9999")), try String(contentsOf: fixtureURL("mask-pattern.html"), encoding: .utf8))
    }

    func testPatternPhone() throws {
        let expected = try String(contentsOf: fixtureURL("mask-pattern-phone.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.xMask.pattern("(999) 999-9999")),
            expected
        )
    }

    func testDynamic() throws {
        HTMLAssertEqual(input(.xMask.dynamic("creditCardMask")), try String(contentsOf: fixtureURL("mask-dynamic.html"), encoding: .utf8))
    }

    func testDynamicConditional() throws {
        HTMLAssertEqual(
            input(.xMask.dynamic("$input.startsWith('34') ? '9999 999999 99999' : '9999 9999 9999 9999'")),
            try String(contentsOf: fixtureURL("mask-dynamic-conditional.html"), encoding: .utf8)
        )
    }

    func testDynamicMoney() throws {
        let expected = try String(contentsOf: fixtureURL("mask-dynamic-money.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.xMask.dynamic("$money($input)")),
            expected
        )
    }

    func testDynamicMoneyWithSeparators() throws {
        HTMLAssertEqual(
            input(.xMask.dynamic("$money($input, '.', ',', 4)")),
            try String(contentsOf: fixtureURL("mask-dynamic-money-separators.html"), encoding: .utf8)
        )
    }
}
