import Elementary
import ElementaryAlpine
import TestUtilities
import XCTest

final class EventHandlingTests: XCTestCase {
    func testClickBasic() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            button(.x.on("click", "count++")) { "Increment" },
            expected
        )
    }

    func testClickPrevent() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-prevent.html"), encoding: .utf8)
        HTMLAssertEqual(
            form(.x.on("submit", "handleSubmit", modifiers: [.prevent])) { button { "Submit" } },
            expected
        )
    }

    func testClickStop() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-stop.html"), encoding: .utf8)
        HTMLAssertEqual(
            a(.x.on("click", "doSomething", modifiers: [.stop])) { "Link" },
            expected
        )
    }

    func testClickCapture() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-capture.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("click", "handle", modifiers: [.capture])) {},
            expected
        )
    }

    func testClickSelf() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-self.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("click", "handle", modifiers: [.selfTarget])) {},
            expected
        )
    }

    func testClickDocument() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-document.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("click", "handle", modifiers: [.document])) {},
            expected
        )
    }

    func testKeyupEnter() throws {
        let expected = try String(contentsOf: fixtureURL("event-keyup-enter.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keyup", "submit", modifiers: [.enter])),
            expected
        )
    }

    func testKeyupEscapeWindow() throws {
        let expected = try String(contentsOf: fixtureURL("event-keyup-escape-window.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keyup", "close", modifiers: [.escape, .window])),
            expected
        )
    }

    func testKeydownCtrl() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-ctrl.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.ctrl])),
            expected
        )
    }

    func testKeydownAlt() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-alt.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.alt])),
            expected
        )
    }

    func testKeydownMeta() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-meta.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.meta])),
            expected
        )
    }

    func testKeydownCmd() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-cmd.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.cmd])),
            expected
        )
    }

    func testKeydownSpace() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-space.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.space])),
            expected
        )
    }

    func testKeydownTab() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-tab.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.tab])),
            expected
        )
    }

    func testKeydownCapsLock() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-caps-lock.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.capsLock])),
            expected
        )
    }

    func testKeydownEqual() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-equal.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.equal])),
            expected
        )
    }

    func testKeydownPeriod() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-period.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.period])),
            expected
        )
    }

    func testKeydownComma() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-comma.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.comma])),
            expected
        )
    }

    func testKeydownSlash() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-slash.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.slash])),
            expected
        )
    }

    func testKeydownUp() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-up.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.up])),
            expected
        )
    }

    func testKeydownDown() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-down.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.down])),
            expected
        )
    }

    func testKeydownLeft() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-left.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.left])),
            expected
        )
    }

    func testKeydownRight() throws {
        let expected = try String(contentsOf: fixtureURL("event-keydown-right.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("keydown", "handle", modifiers: [.right])),
            expected
        )
    }

    func testClickShift() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-shift.html"), encoding: .utf8)
        HTMLAssertEqual(
            button(.x.on("click", "selectAll", modifiers: [.shift])) { "Select All" },
            expected
        )
    }

    func testInputDebounce() throws {
        let expected = try String(contentsOf: fixtureURL("event-input-debounce.html"), encoding: .utf8)
        HTMLAssertEqual(
            input(.x.on("input", "fetchResults", modifiers: [.debounce(500)])),
            expected
        )
    }

    func testScrollThrottle() throws {
        let expected = try String(contentsOf: fixtureURL("event-scroll-throttle.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("scroll", "handleScroll", modifiers: [.throttle(750)])) {},
            expected
        )
    }

    func testTouchstartPassive() throws {
        let expected = try String(contentsOf: fixtureURL("event-touchstart-passive.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("touchstart", "handleTouch", modifiers: [.passive])) {},
            expected
        )
    }

    func testTouchstartPassiveFalse() throws {
        let expected = try String(contentsOf: fixtureURL("event-touchstart-passive-false.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("touchstart", "handleTouch", modifiers: [.passiveFalse])) {},
            expected
        )
    }

    func testClickOutside() throws {
        let expected = try String(contentsOf: fixtureURL("event-outside.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("click", "close", modifiers: [.outside])) {},
            expected
        )
    }

    func testClickOnce() throws {
        let expected = try String(contentsOf: fixtureURL("event-once.html"), encoding: .utf8)
        HTMLAssertEqual(
            button(.x.on("click", "trackEvent", modifiers: [.once])) { "Track" },
            expected
        )
    }

    func testPreventStopChained() throws {
        let expected = try String(contentsOf: fixtureURL("event-prevent-stop-chained.html"), encoding: .utf8)
        HTMLAssertEqual(
            a(.x.on("click", "handle", modifiers: [.prevent, .stop])) { "Link" },
            expected
        )
    }

    func testClickCamel() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-camel.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("click", "handle", modifiers: [.camel])) {},
            expected
        )
    }

    func testClickDot() throws {
        let expected = try String(contentsOf: fixtureURL("event-click-dot.html"), encoding: .utf8)
        HTMLAssertEqual(
            div(.x.on("click", "handle", modifiers: [.dot])) {},
            expected
        )
    }
}
