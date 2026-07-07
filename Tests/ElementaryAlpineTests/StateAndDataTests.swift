import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class StateAndDataTests: XCTestCase {
    func testDataBasic() throws {
        let expected = try String(contentsOf: fixtureURL("state-data-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.data("{ count: 0 }")) {},
            expected
        )
    }

    func testDataComplex() throws {
        let expected = try String(contentsOf: fixtureURL("state-data-complex.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.data("{ open: false, count: 0, items: ['a', 'b'] }")) {},
            expected
        )
    }

    func testInitBasic() throws {
        let expected = try String(contentsOf: fixtureURL("state-init-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.setup("count = 1")) {},
            expected
        )
    }

    func testDataAndInitCombined() throws {
        let expected = try String(contentsOf: fixtureURL("state-data-init-combined.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.data("{ count: 0 }"), .x.setup("count = 1")) {},
            expected
        )
    }

    func testDataWithContent() throws {
        let expected = try String(contentsOf: fixtureURL("state-data-element-with-content.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.data("{ count: 0 }")) {
                button(.x.on("click", "count++")) { "Increment" }
                span(.x.text("count")) {}
            },
            expected
        )
    }
}
