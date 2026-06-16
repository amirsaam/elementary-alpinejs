import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineIntersectTests: XCTestCase {
    func testIntersect() {
        HTMLAttributeAssertEqual(.xIntersect.intersect("loaded = true"), "x-intersect", "loaded = true")
    }

    func testIntersectOnce() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.once]),
            "x-intersect.once",
            "loaded = true"
        )
    }

    func testIntersectHalf() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.half]),
            "x-intersect.half",
            "loaded = true"
        )
    }

    func testIntersectFull() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.full]),
            "x-intersect.full",
            "loaded = true"
        )
    }

    func testIntersectThreshold() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.threshold(50)]),
            "x-intersect.threshold.50",
            "loaded = true"
        )
    }

    func testIntersectThresholdAndFull() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.threshold(50), .full]),
            "x-intersect.threshold.50.full",
            "loaded = true"
        )
    }

    func testIntersectMargin() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.margin("200px")]),
            "x-intersect.margin.200px",
            "loaded = true"
        )
    }

    func testIntersectMarginMulti() {
        HTMLAttributeAssertEqual(
            .xIntersect.intersect("loaded = true", modifiers: [.margin("10%.25px.25.25px")]),
            "x-intersect.margin.10%.25px.25.25px",
            "loaded = true"
        )
    }

    func testEnter() {
        HTMLAttributeAssertEqual(
            .xIntersect.enter("shown = true"),
            "x-intersect:enter",
            "shown = true"
        )
    }

    func testEnterWithModifier() {
        HTMLAttributeAssertEqual(
            .xIntersect.enter("shown = true", modifiers: [.once]),
            "x-intersect:enter.once",
            "shown = true"
        )
    }

    func testLeave() {
        HTMLAttributeAssertEqual(
            .xIntersect.leave("shown = false"),
            "x-intersect:leave",
            "shown = false"
        )
    }

    func testLeaveWithMargin() {
        HTMLAttributeAssertEqual(
            .xIntersect.leave("shown = false", modifiers: [.margin("10%")]),
            "x-intersect:leave.margin.10%",
            "shown = false"
        )
    }
}
