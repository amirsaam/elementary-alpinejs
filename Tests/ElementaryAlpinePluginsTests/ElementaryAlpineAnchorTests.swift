import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineAnchorTests: XCTestCase {
    func testAnchor() {
        HTMLAttributeAssertEqual(.xAnchor.anchor("$refs.button"), "x-anchor", "$refs.button")
    }

    func testAnchorTop() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.top]),
            "x-anchor.top",
            "$refs.button"
        )
    }

    func testAnchorTopStart() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.topStart]),
            "x-anchor.top-start",
            "$refs.button"
        )
    }

    func testAnchorTopEnd() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.topEnd]),
            "x-anchor.top-end",
            "$refs.button"
        )
    }

    func testAnchorBottom() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.bottom]),
            "x-anchor.bottom",
            "$refs.button"
        )
    }

    func testAnchorBottomStart() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.bottomStart]),
            "x-anchor.bottom-start",
            "$refs.button"
        )
    }

    func testAnchorBottomEnd() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.bottomEnd]),
            "x-anchor.bottom-end",
            "$refs.button"
        )
    }

    func testAnchorLeft() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.left]),
            "x-anchor.left",
            "$refs.button"
        )
    }

    func testAnchorLeftStart() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.leftStart]),
            "x-anchor.left-start",
            "$refs.button"
        )
    }

    func testAnchorLeftEnd() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.leftEnd]),
            "x-anchor.left-end",
            "$refs.button"
        )
    }

    func testAnchorRight() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.right]),
            "x-anchor.right",
            "$refs.button"
        )
    }

    func testAnchorRightStart() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.rightStart]),
            "x-anchor.right-start",
            "$refs.button"
        )
    }

    func testAnchorRightEnd() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.rightEnd]),
            "x-anchor.right-end",
            "$refs.button"
        )
    }

    func testAnchorFixed() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.fixed]),
            "x-anchor.fixed",
            "$refs.button"
        )
    }

    func testAnchorOffset() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.offset(10)]),
            "x-anchor.offset.10",
            "$refs.button"
        )
    }

    func testAnchorNoflip() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.noflip]),
            "x-anchor.noflip",
            "$refs.button"
        )
    }

    func testAnchorNoStyle() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.noStyle]),
            "x-anchor.no-style",
            "$refs.button"
        )
    }

    func testAnchorChainedModifiers() {
        HTMLAttributeAssertEqual(
            .xAnchor.anchor("$refs.button", modifiers: [.noStyle, .fixed]),
            "x-anchor.no-style.fixed",
            "$refs.button"
        )
    }
}
