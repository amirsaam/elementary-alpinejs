import Elementary
import XCTest

public func HTMLAttributeAssertEqual(
    _ attribute: HTMLAttribute<HTMLTag.div>,
    _ name: String,
    _ value: String?,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(name, attribute.name, file: file, line: line)
    XCTAssertEqual(value, attribute.value, file: file, line: line)
}

public func HTMLAssertEqual(
    _ html: some HTML,
    _ expected: String,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(html.render(), expected, file: file, line: line)
}

public func fixtureURL(_ name: String, file: StaticString = #filePath) -> URL {
    URL(fileURLWithPath: String(describing: file))
        .deletingLastPathComponent()
        .appendingPathComponent("SnapshotFixtures")
        .appendingPathComponent(name)
}

public func renderToString(@HTMLBuilder _ content: () -> some HTML) -> String {
    content().render()
}
