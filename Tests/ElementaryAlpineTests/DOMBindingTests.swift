import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class DOMBindingTests: XCTestCase {
    // MARK: - x-bind

    func testBindAttribute() throws {
        let expected = try String(contentsOf: fixtureURL("dom-bind-attribute.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.bind("placeholder", "text")),
            expected
        )
    }

    func testBindNoAttribute() throws {
        let expected = try String(contentsOf: fixtureURL("dom-bind-no-attribute.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.bind("trigger")) {},
            expected
        )
    }

    func testBindClass() throws {
        let expected = try String(contentsOf: fixtureURL("dom-bind-class.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.bindClass("{ 'hidden': !show }")) {},
            expected
        )
    }

    func testBindStyle() throws {
        let expected = try String(contentsOf: fixtureURL("dom-bind-style.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.bindStyle("{ color: 'red' }")) {},
            expected
        )
    }

    // MARK: - x-model

    func testModelBasic() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("search")),
            expected
        )
    }

    func testModelNumber() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-number.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("age", modifiers: [.number])),
            expected
        )
    }

    func testModelDebounce() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-debounce.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("search", modifiers: [.debounce(300)])),
            expected
        )
    }

    func testModelChainedModifiers() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-chained.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("search", modifiers: [.change, .blur, .enter, .debounce(300)])),
            expected
        )
    }

    func testModelLazy() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-lazy.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("field", modifiers: [.lazy])),
            expected
        )
    }

    func testModelBoolean() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-boolean.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("active", modifiers: [.boolean])),
            expected
        )
    }

    func testModelFill() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-fill.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("field", modifiers: [.fill])),
            expected
        )
    }

    func testModelThrottle() throws {
        let expected = try String(contentsOf: fixtureURL("dom-model-throttle.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.model("search", modifiers: [.throttle(300)])),
            expected
        )
    }

    // MARK: - x-modelable

    func testModelable() throws {
        let expected = try String(contentsOf: fixtureURL("dom-modelable.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.modelable("value")) {},
            expected
        )
    }

    // MARK: - x-text

    func testTextBasic() throws {
        let expected = try String(contentsOf: fixtureURL("dom-text-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            span(.x.text("count")) {},
            expected
        )
    }

    // MARK: - x-html

    func testHtmlBasic() throws {
        let expected = try String(contentsOf: fixtureURL("dom-html-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.html("<div>raw</div>")) {},
            expected
        )
    }

    // MARK: - x-show

    func testShowBasic() throws {
        let expected = try String(contentsOf: fixtureURL("dom-show-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.show("open")) {},
            expected
        )
    }

    func testShowImportant() throws {
        let expected = try String(contentsOf: fixtureURL("dom-show-important.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.show("open", modifiers: [.important])) {},
            expected
        )
    }
}
