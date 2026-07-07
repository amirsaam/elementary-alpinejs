import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineResizeTests: XCTestCase {
    func testResize() throws {
        let expected = try String(contentsOf: fixtureURL("resize-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xResize.resize("width = $width; height = $height")) {},
            expected
        )
    }

    func testResizeDocument() throws {
        let expected = try String(contentsOf: fixtureURL("resize-document.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xResize.resize("width = $width", modifiers: [.document])) {},
            expected
        )
    }
}
