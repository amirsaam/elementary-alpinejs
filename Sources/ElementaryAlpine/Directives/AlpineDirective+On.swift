import Elementary

/// Modifiers for the `x-on` directive.
/// See the [AlpineJS x-on modifier docs](https://alpinejs.dev/directives/on#modifiers) for the full reference.
public enum OnModifier {
    /// `.prevent` — calls `event.preventDefault()` before the handler runs.
    case prevent
    /// `.stop` — calls `event.stopPropagation()` before the handler runs.
    case stop
    /// `.once` — the handler fires only the first time the event occurs.
    case once
    /// `.capture` — attaches the listener in capture phase instead of bubble phase.
    case capture
    /// `.self` — fires the handler only when `$event.target` is the element itself.
    case selfTarget
    /// `.shift` — fires only when the Shift key is held.
    case shift
    /// `.ctrl` — fires only when the Ctrl key is held.
    case ctrl
    /// `.alt` — fires only when the Alt key is held.
    case alt
    /// `.meta` — fires only when the Meta (Command/Windows) key is held.
    case meta
    /// `.cmd` — alias for `.meta`.
    case cmd
    /// `.enter` — keyboard modifier: fires only on the Enter key.
    case enter
    /// `.escape` — keyboard modifier: fires only on the Escape key.
    case escape
    /// `.space` — keyboard modifier: fires only on the Space key.
    case space
    /// `.tab` — keyboard modifier: fires only on the Tab key.
    case tab
    /// `.caps-lock` — keyboard modifier: fires only when Caps Lock is active.
    case capsLock
    /// `.equal` — keyboard modifier: fires only on the `=` key.
    case equal
    /// `.period` — keyboard modifier: fires only on the `.` key.
    case period
    /// `.comma` — keyboard modifier: fires only on the `,` key.
    case comma
    /// `.slash` — keyboard modifier: fires only on the `/` key.
    case slash
    /// `.up` — keyboard modifier: fires only on the Up arrow key.
    case up
    /// `.down` — keyboard modifier: fires only on the Down arrow key.
    case down
    /// `.left` — keyboard modifier: fires only on the Left arrow key.
    case left
    /// `.right` — keyboard modifier: fires only on the Right arrow key.
    case right
    /// `.window` — listens on the `window` object instead of the element.
    case window
    /// `.document` — listens on the `document` object instead of the element.
    case document
    /// `.outside` — fires only when the event occurs outside the element.
    case outside
    /// `.passive` — marks the listener as passive (improves scroll performance).
    case passive
    /// `.passive.false` — marks the listener as explicitly non-passive.
    case passiveFalse
    /// `.camel` — converts the bound attribute name to camelCase (useful for `x-bind`).
    case camel
    /// `.dot` — converts the bound attribute name to dot-notation (useful for `x-bind`).
    case dot
    /// `.debounce.MSms` — debounces the handler by the given number of milliseconds.
    case debounce(Int)
    /// `.throttle.MSms` — throttles the handler to fire at most once per the given number of milliseconds.
    case throttle(Int)

    var rawValue: String {
        switch self {
        case .prevent: "prevent"
        case .stop: "stop"
        case .once: "once"
        case .capture: "capture"
        case .selfTarget: "self"
        case .shift: "shift"
        case .ctrl: "ctrl"
        case .alt: "alt"
        case .meta: "meta"
        case .cmd: "cmd"
        case .enter: "enter"
        case .escape: "escape"
        case .space: "space"
        case .tab: "tab"
        case .capsLock: "caps-lock"
        case .equal: "equal"
        case .period: "period"
        case .comma: "comma"
        case .slash: "slash"
        case .up: "up"
        case .down: "down"
        case .left: "left"
        case .right: "right"
        case .window: "window"
        case .document: "document"
        case .outside: "outside"
        case .passive: "passive"
        case .passiveFalse: "passive.false"
        case .camel: "camel"
        case .dot: "dot"
        case .debounce(let ms): "debounce.\(ms)ms"
        case .throttle(let ms): "throttle.\(ms)ms"
        }
    }
}

extension HTMLAttribute.x {
    /// Generates an `x-on:EVENT` attribute that listens for an event and runs a JavaScript handler.
    ///
    /// - Parameters:
    ///   - event: The event name to listen for (e.g., `"click"`, `"keyup"`).
    ///   - value: A JavaScript expression or function reference to run when the event fires.
    ///   - modifiers: Optional modifiers (e.g., `.prevent`, `.enter`, `.debounce(500)`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <button x-on:click="count++">
    /// <form x-on:submit.prevent="handleSubmit()">
    /// <input x-on:keyup.enter="submit()">
    /// <input x-on:input.debounce.500ms="fetchResults()">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// button(.x.on("click", "count++")) { "Increment" }
    /// form(.x.on("submit", "handleSubmit()", modifiers: [.prevent])) { ... }
    /// input(.x.on("keyup", "submit()", modifiers: [.enter]))
    /// ```
    public static func on(_ event: String, _ value: String, modifiers: [OnModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-on:\(event)", value: value)
        }
        return .init(name: "x-on:\(event).\(modifiers.map(\.rawValue).joined(separator: "."))", value: value)
    }
}
