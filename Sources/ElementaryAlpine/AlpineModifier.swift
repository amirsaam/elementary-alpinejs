import Elementary

/// A modifier whose `rawValue` is dot-joined to an Alpine directive's base name.
internal protocol AlpineDirectiveModifier {
    var rawValue: String { get }
}

/// Returns an `HTMLAttribute` whose name is `baseName` dot-joined with the
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
