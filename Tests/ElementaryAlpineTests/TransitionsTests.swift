import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class TransitionsTests: XCTestCase {
    // MARK: - Bare transition

    func testTransitionBare() throws {
        HTMLAttributeAssertEqual(.x.transition(), "x-transition", nil)
    }

    // MARK: - Sub-directives

    func testTransitionEnter() throws {
        HTMLAttributeAssertEqual(
            .x.transitionEnter("duration-300 ease-out"),
            "x-transition:enter",
            "duration-300 ease-out"
        )
    }

    func testTransitionEnterStart() throws {
        HTMLAttributeAssertEqual(
            .x.transitionEnterStart("opacity-0"),
            "x-transition:enter-start",
            "opacity-0"
        )
    }

    func testTransitionEnterEnd() throws {
        HTMLAttributeAssertEqual(
            .x.transitionEnterEnd("opacity-100"),
            "x-transition:enter-end",
            "opacity-100"
        )
    }

    func testTransitionLeave() throws {
        HTMLAttributeAssertEqual(
            .x.transitionLeave("duration-200 ease-in"),
            "x-transition:leave",
            "duration-200 ease-in"
        )
    }

    func testTransitionLeaveStart() throws {
        HTMLAttributeAssertEqual(
            .x.transitionLeaveStart("opacity-100"),
            "x-transition:leave-start",
            "opacity-100"
        )
    }

    func testTransitionLeaveEnd() throws {
        HTMLAttributeAssertEqual(
            .x.transitionLeaveEnd("opacity-0"),
            "x-transition:leave-end",
            "opacity-0"
        )
    }

    // MARK: - Modifiers

    func testTransitionOpacity() throws {
        HTMLAttributeAssertEqual(.x.transition(modifiers: [.opacity]), "x-transition.opacity", nil)
    }

    func testTransitionScale() throws {
        HTMLAttributeAssertEqual(.x.transition(modifiers: [.scale()]), "x-transition.scale", nil)
        HTMLAttributeAssertEqual(.x.transition(modifiers: [.scale(80)]), "x-transition.scale.80", nil)
    }

    func testTransitionDuration() throws {
        HTMLAttributeAssertEqual(.x.transition(modifiers: [.duration(500)]), "x-transition.duration.500ms", nil)
    }

    func testTransitionDelay() throws {
        HTMLAttributeAssertEqual(.x.transition(modifiers: [.delay(50)]), "x-transition.delay.50ms", nil)
    }

    func testTransitionOrigin() throws {
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.top)]),
            "x-transition.scale.origin.top",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.bottom)]),
            "x-transition.scale.origin.bottom",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.left)]),
            "x-transition.scale.origin.left",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.right)]),
            "x-transition.scale.origin.right",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.topLeft)]),
            "x-transition.scale.origin.top.left",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.topRight)]),
            "x-transition.scale.origin.top.right",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.bottomLeft)]),
            "x-transition.scale.origin.bottom.left",
            nil
        )
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(), .origin(.bottomRight)]),
            "x-transition.scale.origin.bottom.right",
            nil
        )
    }

    func testTransitionScaleWithOrigin() throws {
        HTMLAttributeAssertEqual(
            .x.transition(modifiers: [.scale(80), .origin(.topRight)]),
            "x-transition.scale.80.origin.top.right",
            nil
        )
    }
}
