import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-for` attribute that renders a `<template>` for each item in an iterable.
    ///
    /// - Parameter value: A JavaScript `x-for` expression (e.g., `"item in items"`, `"(item, index) in items"`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <template x-for="item in items"><li x-text="item.name"></li></template>
    /// <template x-for="(item, index) in items" x-bind:key="item.id">...</template>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// template(.x.loop("item in items")) {
    ///     li(.x.text("item.name")) { "" }
    /// }
    /// ```
    public static func loop(_ value: String) -> HTMLAttribute {
        .init(name: "x-for", value: value)
    }
}
