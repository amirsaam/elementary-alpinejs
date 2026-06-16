import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineSortTests: XCTestCase {
    func testSortWithValue() {
        HTMLAttributeAssertEqual(
            .xSort.sort("alert($item + ' - ' + $position)"),
            "x-sort",
            "alert($item + ' - ' + $position)"
        )
    }

    func testSortNoValue() {
        HTMLAttributeAssertEqual(.xSort.sort, "x-sort", nil)
    }

    func testSortWithModifier() {
        HTMLAttributeAssertEqual(
            .xSort.sort(modifiers: [.ghost]),
            "x-sort.ghost",
            nil
        )
    }

    func testSortWithValueAndModifier() {
        HTMLAttributeAssertEqual(
            .xSort.sort("handle", modifiers: [.ghost]),
            "x-sort.ghost",
            "handle"
        )
    }

    func testItem() {
        HTMLAttributeAssertEqual(.xSort.item("1"), "x-sort:item", "1")
    }

    func testGroup() {
        HTMLAttributeAssertEqual(.xSort.group("todos"), "x-sort:group", "todos")
    }

    func testHandle() {
        HTMLAttributeAssertEqual(.xSort.handle, "x-sort:handle", nil)
    }

    func testIgnore() {
        HTMLAttributeAssertEqual(.xSort.ignore, "x-sort:ignore", nil)
    }

    func testConfig() {
        HTMLAttributeAssertEqual(
            .xSort.config("{ animation: 0 }"),
            "x-sort:config",
            "{ animation: 0 }"
        )
    }
}
