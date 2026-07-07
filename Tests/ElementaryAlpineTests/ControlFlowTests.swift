import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class ControlFlowTests: XCTestCase {
    func testForBasic() throws {
        let expected = try String(contentsOf: fixtureURL("flow-for-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            template(.x.loop("item in items")) {},
            expected
        )
    }

    func testIfBasic() throws {
        let expected = try String(contentsOf: fixtureURL("flow-if-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            template(.x.when("open")) {},
            expected
        )
    }

    func testForWithContent() throws {
        let expected = try String(contentsOf: fixtureURL("flow-for-with-content.html"), encoding: .utf8)
        HTMLAssertEqual(
            template(.x.loop("item in items")) { li(.x.text("item")) {} },
            expected
        )
    }

    func testIfWithContent() throws {
        let expected = try String(contentsOf: fixtureURL("flow-if-with-content.html"), encoding: .utf8)
        HTMLAssertEqual(
            template(.x.when("open")) { div(.x.show("open")) { "Content" } },
            expected
        )
    }
}
