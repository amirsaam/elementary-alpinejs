import Elementary

/// A modifier whose `rawValue` is dot-joined to an Alpine directive's base name.
internal protocol AlpineDirectiveModifier {
    var rawValue: String { get }
}

/// Placeholder modifier for directives that do not accept modifiers.
/// Used solely to satisfy the `alpineDirective` helper's generic `M` constraint.
internal enum NoModifier: AlpineDirectiveModifier {
    var rawValue: String { "" }
}

/// Returns an `HTMLAttribute<Tag>` whose name is `baseName` dot-joined with the
/// `rawValue` of each modifier, or `baseName` alone when `modifiers` is empty.
internal func alpineDirective<Tag, M: AlpineDirectiveModifier>(
    _ baseName: String,
    modifiers: [M],
    value: String?
) -> HTMLAttribute<Tag> where Tag: HTMLTrait.Attributes.Global {
    if modifiers.isEmpty {
        return HTMLAttribute<Tag>(name: baseName, value: value)
    }
    return HTMLAttribute<Tag>(name: "\(baseName).\(modifiers.map { $0.rawValue }.joined(separator: "."))", value: value)

}

/// Returns an `HTMLAttribute<Tag>` with the given `baseName` and no modifiers.
internal func alpineDirective<Tag>(
    _ baseName: String,
    value: String?
) -> HTMLAttribute<Tag> where Tag: HTMLTrait.Attributes.Global {
    HTMLAttribute<Tag>(name: baseName, value: value)
}
