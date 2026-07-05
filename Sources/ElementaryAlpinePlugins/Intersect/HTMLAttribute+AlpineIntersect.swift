import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Intersect plugin attributes.
    /// See the [Intersect plugin docs](https://alpinejs.dev/plugins/intersect) for more information.
    public enum xIntersect {}
}

extension HTMLAttribute.xIntersect {
    /// Generates an `x-intersect` attribute that runs a JavaScript expression when the element enters the viewport.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression to run when the element enters the viewport.
    ///   - modifiers: Optional modifiers (e.g., `.once`, `.half`, `.threshold(50)`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-intersect="shown = true">
    /// <div x-intersect.once="loaded = true">
    /// <div x-intersect.threshold.50="loaded = true">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.xIntersect.intersect("shown = true")) { ... }
    /// div(.xIntersect.intersect("loaded = true", modifiers: [.once])) { ... }
    /// ```
    public static func intersect(
        _ value: String,
        modifiers: [IntersectModifier] = []
    ) -> HTMLAttribute {
        alpinePluginDirective("x-intersect", modifiers: modifiers, value: value)
    }

    /// Generates an `x-intersect:enter` attribute — an alias of `x-intersect`.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression to run when the element enters the viewport.
    ///   - modifiers: Optional modifiers.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-intersect:enter="shown = true">
    /// ```
    public static func enter(
        _ value: String,
        modifiers: [IntersectModifier] = []
    ) -> HTMLAttribute {
        alpinePluginDirective("x-intersect:enter", modifiers: modifiers, value: value)
    }

    /// Generates an `x-intersect:leave` attribute that runs a JavaScript expression when the element leaves the viewport.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression to run when the element leaves the viewport.
    ///   - modifiers: Optional modifiers.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-intersect:leave="shown = false">
    /// ```
    public static func leave(
        _ value: String,
        modifiers: [IntersectModifier] = []
    ) -> HTMLAttribute {
        alpinePluginDirective("x-intersect:leave", modifiers: modifiers, value: value)
    }
}
