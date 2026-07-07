import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineAnchorTests: XCTestCase {
    func testAnchor() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button")) {},
            expected
        )
    }

    func testAnchorTop() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-top.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.top])) {},
            expected
        )
    }

    func testAnchorTopStart() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-top-start.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.topStart])) {},
            expected
        )
    }

    func testAnchorTopEnd() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-top-end.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.topEnd])) {},
            expected
        )
    }

    func testAnchorBottom() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-bottom.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.bottom])) {},
            expected
        )
    }

    func testAnchorBottomStart() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-bottom-start.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.bottomStart])) {},
            expected
        )
    }

    func testAnchorBottomEnd() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-bottom-end.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.bottomEnd])) {},
            expected
        )
    }

    func testAnchorLeft() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-left.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.left])) {},
            expected
        )
    }

    func testAnchorLeftStart() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-left-start.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.leftStart])) {},
            expected
        )
    }

    func testAnchorLeftEnd() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-left-end.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.leftEnd])) {},
            expected
        )
    }

    func testAnchorRight() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-right.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.right])) {},
            expected
        )
    }

    func testAnchorRightStart() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-right-start.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.rightStart])) {},
            expected
        )
    }

    func testAnchorRightEnd() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-right-end.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.rightEnd])) {},
            expected
        )
    }

    func testAnchorFixed() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-fixed.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.fixed])) {},
            expected
        )
    }

    func testAnchorOffset() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-offset.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.offset(10)])) {},
            expected
        )
    }

    func testAnchorNoflip() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-noflip.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.noflip])) {},
            expected
        )
    }

    func testAnchorNoStyle() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-no-style.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.noStyle])) {},
            expected
        )
    }

    func testAnchorChainedModifiers() throws {
        let expected = try String(contentsOf: fixtureURL("anchor-chained.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xAnchor.anchor("$refs.button", modifiers: [.noStyle, .fixed])) {},
            expected
        )
    }
}
