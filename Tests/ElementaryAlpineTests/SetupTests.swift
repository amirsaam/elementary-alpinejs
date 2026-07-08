import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class SetupTests: XCTestCase {
    func testNoPlugins() throws {
        let expected = try String(contentsOf: fixtureURL("setup-alpine-no-plugins.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(),
            expected
        )
    }

    func testCustomVersion() throws {
        let expected = try String(contentsOf: fixtureURL("setup-alpine-custom-version.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(version: "3.14.0"),
            expected
        )
    }

    func testSinglePlugin() throws {
        let expected = try String(contentsOf: fixtureURL("setup-alpine-single-plugin.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(plugins: [.mask]),
            expected
        )
    }

    func testMultiplePlugins() throws {
        let expected = try String(contentsOf: fixtureURL("setup-multiple-plugins.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(plugins: [.mask, .focus, .morph]),
            expected
        )
    }

    func testPluginOrderBeforeCore() {
        let html = renderToString { setupAlpine(plugins: [.mask, .focus]) }
        let maskRange = html.range(of: "@alpinejs/mask@3.15.12")
        let focusRange = html.range(of: "@alpinejs/focus@3.15.12")
        let alpineRange = html.range(of: "alpinejs@3.15.12/dist/cdn.min.js")
        XCTAssertNotNil(maskRange)
        XCTAssertNotNil(focusRange)
        XCTAssertNotNil(alpineRange)
        XCTAssertLessThan(maskRange!.lowerBound, alpineRange!.lowerBound)
        XCTAssertLessThan(focusRange!.lowerBound, alpineRange!.lowerBound)
    }

    func testDeduplicatesPlugins() {
        let html = renderToString { setupAlpine(plugins: [.mask, .focus, .mask, .focus, .mask]) }
        let maskCount = html.components(separatedBy: "@alpinejs/mask@").count - 1
        let focusCount = html.components(separatedBy: "@alpinejs/focus@").count - 1
        XCTAssertEqual(maskCount, 1)
        XCTAssertEqual(focusCount, 1)
        XCTAssertTrue(html.contains("alpinejs@3.15.12/dist/cdn.min.js"))
    }

    func testCustomVersionWithPlugin() throws {
        let expected = try String(contentsOf: fixtureURL("setup-custom-version-with-plugin.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(version: "3.14.0", plugins: [.morph]),
            expected
        )
    }

    func testAllPluginsEmitCorrectCDNURL() {
        for plugin in AlpinePlugin.allCases {
            let expected = try! String(contentsOf: fixtureURL("setup-plugin-\(plugin.rawValue).html"), encoding: .utf8)
            HTMLAssertEqual(
                setupAlpine(plugins: [plugin]),
                expected
            )
        }
    }
}
