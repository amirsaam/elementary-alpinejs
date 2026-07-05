/// A configuration object for `setupMorph` and `setupMorphBetween` that controls lifecycle hooks,
/// element identity, and the lookahead diffing algorithm. Built by chaining lifecycle methods.
///
/// **Example:**
/// ```swift
/// setupMorph(
///     trigger: "#btn",
///     target: "#list",
///     event: "click",
///     options: {
///         .updating { "console.log('patching', el)" }
///             .key { "(el) => el.id" }
///             .lookahead()
///     }
/// ) {
///     ul { li { "item" } }
/// }
/// ```
public struct MorphOptions {
    /// A closure returning the body of the `updating(el, toEl, childrenOnly, skip)` lifecycle hook.
    /// Called before Morph patches `el`. Return `false` (or call `childrenOnly()` / `skip()`) to alter behavior.
    public var updating: (() -> String)?
    /// A closure returning the body of the `updated(el, toEl)` lifecycle hook.
    /// Called after Morph has patched `el`.
    public var updated: (() -> String)?
    /// A closure returning the body of the `removing(el, skip)` lifecycle hook.
    /// Called before Morph removes an element from the live DOM. Call `skip()` to keep the element.
    public var removing: (() -> String)?
    /// A closure returning the body of the `removed(el)` lifecycle hook.
    /// Called after Morph has removed an element from the live DOM.
    public var removed: (() -> String)?
    /// A closure returning the body of the `adding(el, skip)` lifecycle hook.
    /// Called before Morph adds a new element. Call `skip()` to skip the add.
    public var adding: (() -> String)?
    /// A closure returning the body of the `added(el)` lifecycle hook.
    /// Called after Morph has added a new element to the live DOM.
    public var added: (() -> String)?
    /// A closure returning a JavaScript expression for the `key` option — a function that
    /// returns each element's identity key. Used by the diffing algorithm to match old ↔ new elements.
    public var key: (() -> String)?
    /// Whether to enable Morph's lookahead algorithm, which prefers *moving* an element
    /// over removing-and-recreating it when the element appears later in the new HTML.
    public var lookahead: Bool = false

    public init() {}

    /// Sets the `updating` lifecycle hook. See `updating` for details.
    public func updating(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.updating = js
        return copy
    }

    /// Sets the `updated` lifecycle hook. See `updated` for details.
    public func updated(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.updated = js
        return copy
    }

    /// Sets the `removing` lifecycle hook. See `removing` for details.
    public func removing(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.removing = js
        return copy
    }

    /// Sets the `removed` lifecycle hook. See `removed` for details.
    public func removed(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.removed = js
        return copy
    }

    /// Sets the `adding` lifecycle hook. See `adding` for details.
    public func adding(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.adding = js
        return copy
    }

    /// Sets the `added` lifecycle hook. See `added` for details.
    public func added(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.added = js
        return copy
    }

    /// Sets the `key` option. See `key` for details.
    public func key(_ js: @escaping () -> String) -> MorphOptions {
        var copy = self
        copy.key = js
        return copy
    }

    /// Sets the `lookahead` flag. Calling `.lookahead()` with no argument enables it
    /// (`enabled` defaults to `true`). The struct field itself defaults to `false`,
    /// so this method must be called to turn lookahead on.
    /// - Parameter enabled: Pass `false` to explicitly disable lookahead.
    public func lookahead(_ enabled: Bool = true) -> MorphOptions {
        var copy = self
        copy.lookahead = enabled
        return copy
    }

    /// Static factory: creates a `MorphOptions` with only the `updating` hook set.
    public static func updating(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().updating(js)
    }
    /// Static factory: creates a `MorphOptions` with only the `updated` hook set.
    public static func updated(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().updated(js)
    }
    /// Static factory: creates a `MorphOptions` with only the `removing` hook set.
    public static func removing(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().removing(js)
    }
    /// Static factory: creates a `MorphOptions` with only the `removed` hook set.
    public static func removed(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().removed(js)
    }
    /// Static factory: creates a `MorphOptions` with only the `adding` hook set.
    public static func adding(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().adding(js)
    }
    /// Static factory: creates a `MorphOptions` with only the `added` hook set.
    public static func added(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().added(js)
    }
    /// Static factory: creates a `MorphOptions` with only the `key` option set.
    public static func key(_ js: @escaping () -> String) -> MorphOptions {
        MorphOptions().key(js)
    }
    /// Static factory: creates a `MorphOptions` with only `lookahead` enabled.
    public static func lookahead(_ enabled: Bool = true) -> MorphOptions {
        var opts = MorphOptions()
        opts.lookahead = enabled
        return opts
    }

    func toJS() -> String {
        var parts: [String] = []
        if let updating = updating {
            parts.append("updating(el, toEl, childrenOnly, skip) { \(updating()) }")
        }
        if let updated = updated {
            parts.append("updated(el, toEl) { \(updated()) }")
        }
        if let removing = removing {
            parts.append("removing(el, skip) { \(removing()) }")
        }
        if let removed = removed {
            parts.append("removed(el) { \(removed()) }")
        }
        if let adding = adding {
            parts.append("adding(el, skip) { \(adding()) }")
        }
        if let added = added {
            parts.append("added(el) { \(added()) }")
        }
        if let key = key {
            parts.append("key: \(key())")
        }
        if lookahead {
            parts.append("lookahead: true")
        }
        return parts.isEmpty ? "" : "{ \(parts.joined(separator: ", ")) }"
    }
}
