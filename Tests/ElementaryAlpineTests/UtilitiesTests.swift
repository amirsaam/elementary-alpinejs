import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class UtilitiesTests: XCTestCase {
    func testEffect() throws {
        let expected = try String(contentsOf: fixtureURL("util-effect-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.effect("console.log(count)")) {},
            expected
        )
    }

    func testIgnore() throws {
        let expected = try String(contentsOf: fixtureURL("util-ignore-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.ignore) {},
            expected
        )
    }

    func testRef() throws {
        let expected = try String(contentsOf: fixtureURL("util-ref-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.ref("searchInput")),
            expected
        )
    }

    func testCloak() throws {
        let expected = try String(contentsOf: fixtureURL("util-cloak-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.cloak) {},
            expected
        )
    }

    func testTeleport() throws {
        let expected = try String(contentsOf: fixtureURL("util-teleport-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.teleport("body")) {},
            expected
        )
    }

    func testId() throws {
        let expected = try String(contentsOf: fixtureURL("util-id-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.id("modal")) {},
            expected
        )
    }
}
