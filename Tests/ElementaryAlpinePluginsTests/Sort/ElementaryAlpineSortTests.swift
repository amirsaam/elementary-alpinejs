import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineSortTests: XCTestCase {
    func testSortWithValue() throws {
        let expected = try String(contentsOf: fixtureURL("sort-value.html"), encoding: .utf8)
        HTMLAssertEqual(
            ul(.xSort.sort("alert($item + ' - ' + $position)")) {},
            expected
        )
    }

    func testSortNoValue() throws {
        let expected = try String(contentsOf: fixtureURL("sort-bare.html"), encoding: .utf8)
        HTMLAssertEqual(
            ul(.xSort.sort) {},
            expected
        )
    }

    func testSortWithModifier() throws {
        let expected = try String(contentsOf: fixtureURL("sort-ghost.html"), encoding: .utf8)
        HTMLAssertEqual(
            ul(.xSort.sort(modifiers: [.ghost])) {},
            expected
        )
    }

    func testSortWithValueAndModifier() throws {
        let expected = try String(contentsOf: fixtureURL("sort-value-ghost.html"), encoding: .utf8)
        HTMLAssertEqual(
            ul(.xSort.sort("handle", modifiers: [.ghost])) {},
            expected
        )
    }

    func testItem() throws {
        let expected = try String(contentsOf: fixtureURL("sort-item.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xSort.item("1")) {},
            expected
        )
    }

    func testGroup() throws {
        let expected = try String(contentsOf: fixtureURL("sort-group.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xSort.group("todos")) {},
            expected
        )
    }

    func testHandle() throws {
        let expected = try String(contentsOf: fixtureURL("sort-handle.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xSort.handle) {},
            expected
        )
    }

    func testIgnore() throws {
        let expected = try String(contentsOf: fixtureURL("sort-ignore.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xSort.ignore) {},
            expected
        )
    }

    func testConfig() throws {
        let expected = try String(contentsOf: fixtureURL("sort-config.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xSort.config("{ animation: 0 }")) {},
            expected
        )
    }
}
