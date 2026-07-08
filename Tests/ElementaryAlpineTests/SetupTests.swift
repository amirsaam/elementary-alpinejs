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

    func testPluginOrderBeforeCore() {
        let expected = try! String(contentsOf: fixtureURL("setup-plugin-order.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(plugins: [.mask, .focus]),
            expected
        )
    }

    func testDeduplicatesPlugins() {
        let expected = try! String(contentsOf: fixtureURL("setup-deduplicates.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(plugins: [.mask, .focus, .mask, .focus, .mask]),
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

    func testCustomVersionPropagatesToPlugins() throws {
        let expected = try String(contentsOf: fixtureURL("setup-custom-version-with-plugins.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupAlpine(version: "3.14.0", plugins: [.mask, .focus]),
            expected
        )
    }
}
