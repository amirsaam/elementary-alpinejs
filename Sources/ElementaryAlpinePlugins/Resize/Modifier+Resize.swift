/// Modifiers for the `x-resize` directive.
/// See the [AlpineJS Resize plugin docs](https://alpinejs.dev/plugins/resize) for the full reference.
public enum ResizeModifier: AlpinePluginDirectiveModifier {
    /// `.document` — observe the `document` instead of a specific element.
    case document

    var rawValue: String {
        switch self {
        case .document: "document"
        }
    }
}
