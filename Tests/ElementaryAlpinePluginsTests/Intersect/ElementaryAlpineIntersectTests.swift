import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineIntersectTests: XCTestCase {
    func testIntersect() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true")) {},
            expected
        )
    }

    func testIntersectOnce() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-once.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true", modifiers: [.once])) {},
            expected
        )
    }

    func testIntersectHalf() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-half.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true", modifiers: [.half])) {},
            expected
        )
    }

    func testIntersectFull() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-full.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true", modifiers: [.full])) {},
            expected
        )
    }

    func testIntersectThreshold() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-threshold-50.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true", modifiers: [.threshold(50)])) {},
            expected
        )
    }

    func testIntersectThresholdAndFull() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-threshold-50-full.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true", modifiers: [.threshold(50), .full])) {},
            expected
        )
    }

    func testIntersectMargin() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-margin.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.intersect("loaded = true", modifiers: [.margin("200px")])) {},
            expected
        )
    }

    func testEnter() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-enter.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.enter("shown = true")) {},
            expected
        )
    }

    func testEnterWithModifier() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-enter-once.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.enter("shown = true", modifiers: [.once])) {},
            expected
        )
    }

    func testLeave() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-leave.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.leave("shown = false")) {},
            expected
        )
    }

    func testLeaveWithMargin() throws {
        let expected = try String(contentsOf: fixtureURL("intersect-leave-margin.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.xIntersect.leave("shown = false", modifiers: [.margin("10%")])) {},
            expected
        )
    }
}
