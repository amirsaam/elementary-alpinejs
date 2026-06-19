import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Sort plugin attributes.
    /// See the [Sort plugin docs](https://alpinejs.dev/plugins/sort) for more information.
    public enum xSort {}
}

extension HTMLAttribute.xSort {
    /// Generates an `x-sort` attribute that makes a list of children re-orderable by drag-and-drop (built on SortableJS).
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression (or function reference) called on every reorder. Receives
    ///     `$item` (the moved item's key) and `$position` (its new index, 0-based) as magics.
    ///   - modifiers: Optional modifiers (e.g., `.ghost`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <ul x-sort>
    /// <ul x-sort="alert($item + ' - ' + $position)">
    /// <ul x-sort.ghost>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// ul(.xSort.sort) {
    ///     li(.xSort.item("1")) { "foo" }
    ///     li(.xSort.item("2")) { "bar" }
    /// }
    /// ul(.xSort.sort("alert($item + ' - ' + $position)")) {
    ///     li(.xSort.item("1")) { "foo" }
    /// }
    /// ul(.xSort.sort(modifiers: [.ghost])) {
    ///     li(.xSort.item("1")) { "foo" }
    /// }
    /// ```
    public static func sort(
        _ value: String,
        modifiers: [SortModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-sort", value: value)
        }
        return .init(
            name: "x-sort.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }

    /// Generates a bare `x-sort` attribute with no handler — items are draggable but no callback fires.
    ///
    /// - Parameter modifiers: Optional modifiers.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <ul x-sort>
    /// ```
    public static var sort: HTMLAttribute {
        .init(name: "x-sort", value: nil)
    }

    /// Generates a bare `x-sort` attribute with modifiers but no handler.
    ///
    /// - Parameter modifiers: Optional modifiers.
    public static func sort(
        modifiers: [SortModifier]
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-sort", value: nil)
        }
        return .init(
            name: "x-sort.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: nil
        )
    }

    /// Generates an `x-sort:item` attribute that uniquely identifies a sortable item.
    ///
    /// - Parameter value: The item's key (typically a numeric or string ID).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <li x-sort:item="1">foo</li>
    /// ```
    public static func item(_ value: String) -> HTMLAttribute {
        .init(name: "x-sort:item", value: value)
    }

    /// Generates an `x-sort:group` attribute that lets items be dragged between lists sharing the same group name.
    ///
    /// - Parameter value: The group name.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <ul x-sort="handle" x-sort:group="todos">
    /// ```
    public static func group(_ value: String) -> HTMLAttribute {
        .init(name: "x-sort:group", value: value)
    }

    /// Generates an `x-sort:handle` attribute that marks an element as a drag handle (only the handle initiates drag).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <span x-sort:handle> - </span>
    /// ```
    public static var handle: HTMLAttribute {
        .init(name: "x-sort:handle", value: nil)
    }

    /// Generates an `x-sort:ignore` attribute that marks an element as not draggable (e.g., a button inside an item).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <button x-sort:ignore>Edit</button>
    /// ```
    public static var ignore: HTMLAttribute {
        .init(name: "x-sort:ignore", value: nil)
    }

    /// Generates an `x-sort:config` attribute that passes a custom SortableJS options object.
    ///
    /// - Parameter value: A JavaScript object literal of [SortableJS options](https://github.com/SortableJS/Sortable?tab=readme-ov-file#options).
    ///   Be aware that overwriting `handle`, `group`, `filter`, `onSort`, `onStart`, or `onEnd` may break functionality.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <ul x-sort x-sort:config="{ animation: 0 }">
    /// ```
    public static func config(_ value: String) -> HTMLAttribute {
        .init(name: "x-sort:config", value: value)
    }
}
