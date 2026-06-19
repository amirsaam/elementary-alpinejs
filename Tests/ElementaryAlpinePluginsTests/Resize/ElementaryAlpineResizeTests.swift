import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineResizeTests: XCTestCase {
    func testResize() {
        HTMLAttributeAssertEqual(
            .xResize.resize("width = $width; height = $height"),
            "x-resize",
            "width = $width; height = $height"
        )
    }

    func testResizeDocument() {
        HTMLAttributeAssertEqual(
            .xResize.resize("width = $width", modifiers: [.document]),
            "x-resize.document",
            "width = $width"
        )
    }
}
