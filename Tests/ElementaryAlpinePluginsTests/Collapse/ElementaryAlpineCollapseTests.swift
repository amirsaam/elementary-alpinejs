import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineCollapseTests: XCTestCase {
    func testCollapse() {
        HTMLAttributeAssertEqual(.xCollapse.collapse(), "x-collapse", nil)
    }

    func testCollapseDuration() {
        HTMLAttributeAssertEqual(
            .xCollapse.collapse(modifiers: [.duration(1000)]),
            "x-collapse.duration.1000ms",
            nil
        )
    }

    func testCollapseMin() {
        HTMLAttributeAssertEqual(
            .xCollapse.collapse(modifiers: [.min(50)]),
            "x-collapse.min.50px",
            nil
        )
    }

    func testCollapseDurationAndMin() {
        HTMLAttributeAssertEqual(
            .xCollapse.collapse(modifiers: [.duration(500), .min(50)]),
            "x-collapse.duration.500ms.min.50px",
            nil
        )
    }
}
