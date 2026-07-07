import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineCollapseTests: XCTestCase {
    func testCollapse() throws {
        let expected = try String(contentsOf: fixtureURL("collapse-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xCollapse.collapse()) {},
            expected
        )
    }

    func testCollapseDuration() throws {
        let expected = try String(contentsOf: fixtureURL("collapse-duration.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xCollapse.collapse(modifiers: [.duration(1000)])) {},
            expected
        )
    }

    func testCollapseMin() throws {
        let expected = try String(contentsOf: fixtureURL("collapse-min.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xCollapse.collapse(modifiers: [.min(50)])) {},
            expected
        )
    }

    func testCollapseDurationAndMin() throws {
        let expected = try String(contentsOf: fixtureURL("collapse-duration-min.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xCollapse.collapse(modifiers: [.duration(500), .min(50)])) {},
            expected
        )
    }
}
