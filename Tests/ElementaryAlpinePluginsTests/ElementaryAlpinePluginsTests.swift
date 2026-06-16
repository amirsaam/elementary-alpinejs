import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpinePluginsTests: XCTestCase {
    func testMaskPattern() {
        HTMLAttributeAssertEqual(.xMask.pattern("99/99/9999"), "x-mask", "99/99/9999")
    }

    func testMaskPatternPhone() {
        HTMLAttributeAssertEqual(.xMask.pattern("(999) 999-9999"), "x-mask", "(999) 999-9999")
    }

    func testMaskDynamic() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("creditCardMask"),
            "x-mask:dynamic",
            "creditCardMask"
        )
    }

    func testMaskDynamicConditional() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("$input.startsWith('34') ? '9999 999999 99999' : '9999 9999 9999 9999'"),
            "x-mask:dynamic",
            "$input.startsWith('34') ? '9999 999999 99999' : '9999 9999 9999 9999'"
        )
    }

    func testMaskDynamicMoney() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("$money($input)"),
            "x-mask:dynamic",
            "$money($input)"
        )
    }

    func testMaskDynamicMoneyWithSeparators() {
        HTMLAttributeAssertEqual(
            .xMask.dynamic("$money($input, '.', ',', 4)"),
            "x-mask:dynamic",
            "$money($input, '.', ',', 4)"
        )
    }
}
