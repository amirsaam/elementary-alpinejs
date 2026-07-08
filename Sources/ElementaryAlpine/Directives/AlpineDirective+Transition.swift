import Elementary

/// Modifiers for the `x-transition` directive.
/// See the [AlpineJS x-transition modifier docs](https://alpinejs.dev/directives/transition#modifiers) for the full reference.
public enum TransitionModifier: AlpineDirectiveModifier {
    /// A position enum used by `.origin(...)` to specify the transform origin.
    public enum Origin {
        /// `top` — origin at the top center.
        case top
        /// `bottom` — origin at the bottom center.
        case bottom
        /// `left` — origin at the left center.
        case left
        /// `right` — origin at the right center.
        case right
        /// `top-left` — origin at the top-left corner.
        case topLeft
        /// `top-right` — origin at the top-right corner.
        case topRight
        /// `bottom-left` — origin at the bottom-left corner.
        case bottomLeft
        /// `bottom-right` — origin at the bottom-right corner.
        case bottomRight

        var rawValue: String {
            switch self {
            case .top: "top"
            case .bottom: "bottom"
            case .left: "left"
            case .right: "right"
            case .topLeft: "top.left"
            case .topRight: "top.right"
            case .bottomLeft: "bottom.left"
            case .bottomRight: "bottom.right"
            }
        }
    }

    /// `.opacity` — transition the element's opacity.
    case opacity
    /// `.scale` (or `.scale.PCT`) — transition the element's scale. Pass an optional percentage (0–100) to override the default (95).
    case scale(Int? = nil)
    /// `.origin.POS` — set the transform origin. Use one of the `Origin` cases.
    case origin(Origin)
    /// `.duration.MSms` — set the transition duration in milliseconds.
    case duration(Int)
    /// `.delay.MSms` — set the transition delay in milliseconds.
    case delay(Int)

    var rawValue: String {
        switch self {
        case .opacity: "opacity"
        case .scale(let percentage): percentage.map { "scale.\($0)" } ?? "scale"
        case .origin(let value): "origin.\(value.rawValue)"
        case .duration(let ms): "duration.\(ms)ms"
        case .delay(let ms): "delay.\(ms)ms"
        }
    }
}

extension HTMLAttribute.x {
    /// Generates an `x-transition` attribute that applies Alpine's default enter/leave transition.
    ///
    /// - Parameter modifiers: Optional modifiers (e.g., `.opacity`, `.scale(80)`, `.duration(500)`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition>
    /// <div x-transition.opacity>
    /// <div x-transition.scale.80.origin.top>
    /// <div x-transition.duration.500ms.delay.50ms>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.show("open"), .x.transition(modifiers: [.opacity])) { ... }
    /// div(.x.show("open"), .x.transition(modifiers: [.scale(80), .origin(.top)])) { ... }
    /// ```
    public static func transition(modifiers: [TransitionModifier] = []) -> HTMLAttribute {
        alpineDirective("x-transition", modifiers: modifiers, value: nil)
    }

    /// Generates an `x-transition:enter` attribute that applies a CSS class during the enter phase.
    ///
    /// - Parameter value: The CSS class names to apply.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition:enter="transition ease-out duration-300">
    /// ```
    public static func transitionEnter(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:enter", value: value)
    }

    /// Generates an `x-transition:enter-start` attribute that applies a CSS class at the start of the enter phase.
    ///
    /// - Parameter value: The CSS class names to apply.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition:enter-start="opacity-0 transform translate-x-full">
    /// ```
    public static func transitionEnterStart(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:enter-start", value: value)
    }

    /// Generates an `x-transition:enter-end` attribute that applies a CSS class at the end of the enter phase.
    ///
    /// - Parameter value: The CSS class names to apply.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition:enter-end="opacity-100 transform translate-x-0">
    /// ```
    public static func transitionEnterEnd(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:enter-end", value: value)
    }

    /// Generates an `x-transition:leave` attribute that applies a CSS class during the leave phase.
    ///
    /// - Parameter value: The CSS class names to apply.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition:leave="transition ease-in duration-200">
    /// ```
    public static func transitionLeave(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:leave", value: value)
    }

    /// Generates an `x-transition:leave-start` attribute that applies a CSS class at the start of the leave phase.
    ///
    /// - Parameter value: The CSS class names to apply.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition:leave-start="opacity-100 transform translate-x-0">
    /// ```
    public static func transitionLeaveStart(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:leave-start", value: value)
    }

    /// Generates an `x-transition:leave-end` attribute that applies a CSS class at the end of the leave phase.
    ///
    /// - Parameter value: The CSS class names to apply.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-transition:leave-end="opacity-0 transform -translate-x-full">
    /// ```
    public static func transitionLeaveEnd(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:leave-end", value: value)
    }
}
