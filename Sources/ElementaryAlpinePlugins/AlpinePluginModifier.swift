import Elementary

/// A modifier whose `rawValue` is dot-joined to an Alpine plugin directive's base name.
internal protocol AlpinePluginDirectiveModifier {
    var rawValue: String { get }
}

/// Returns an `HTMLAttribute` whose name is `baseName` dot-joined with the
/// `rawValue` of each modifier, or `baseName` alone when `modifiers` is empty.
internal func alpinePluginDirective<Tag, M: AlpinePluginDirectiveModifier>(
    _ baseName: String,
    modifiers: [M],
    value: String?
) -> HTMLAttribute<Tag> where Tag: HTMLTrait.Attributes.Global {
    if modifiers.isEmpty {
        return HTMLAttribute<Tag>(name: baseName, value: value)
    }
    return HTMLAttribute<Tag>(name: "\(baseName).\(modifiers.map { $0.rawValue }.joined(separator: "."))", value: value)

}

/// Returns an `HTMLAttribute` with the given `baseName` and no modifiers.
internal func alpinePluginDirective<Tag>(
    _ baseName: String,
    value: String?
) -> HTMLAttribute<Tag> where Tag: HTMLTrait.Attributes.Global {
    HTMLAttribute<Tag>(name: baseName, value: value)
}
