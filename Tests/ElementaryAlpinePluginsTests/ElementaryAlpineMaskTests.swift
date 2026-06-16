import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineMaskTests: XCTestCase {
    func testPattern() {
        HTMLAttributeAssertEqual(.xMask.pattern("99/99/9999"), "x-mask", "99/99/9999")
    }

    func testPatternPhone() {
        HTMLAttributeAssertEqual(.xMask.pattern("(999) 999-9999"), "x-mask", "(999) 999-9999")
    }

    func testDynamic() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("creditCardMask"),
            "x-mask:dynamic",
            "creditCardMask"
        )
    }

    func testDynamicConditional() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("$input.startsWith('34') ? '9999 999999 99999' : '9999 9999 9999 9999'"),
            "x-mask:dynamic",
            "$input.startsWith('34') ? '9999 999999 99999' : '9999 9999 9999 9999'"
        )
    }

    func testDynamicMoney() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("$money($input)"),
            "x-mask:dynamic",
            "$money($input)"
        )
    }

    func testDynamicMoneyWithSeparators() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("$money($input, '.', ',', 4)"),
            "x-mask:dynamic",
            "$money($input, '.', ',', 4)"
        )
    }
}
