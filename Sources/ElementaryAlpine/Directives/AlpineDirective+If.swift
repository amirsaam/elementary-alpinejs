import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-if` attribute on a `<template>` that conditionally renders its children.
    ///
    /// - Parameter value: A JavaScript expression that evaluates to a boolean.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <template x-if="open"><div>Content</div></template>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// template(.x.when("open")) {
    ///     div { "Content" }
    /// }
    /// ```
    ///
    /// **Notes:**
    /// Named `.when` because `if` is a Swift keyword.
    public static func when(_ value: String) -> HTMLAttribute<Tag> {
        alpineDirective("x-if", value: value)
    }
}
