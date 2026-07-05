/// Modifiers for the `x-anchor` directive.
/// See the [AlpineJS Anchor plugin docs](https://alpinejs.dev/plugins/anchor#modifiers) for the full reference.
public enum AnchorModifier: AlpinePluginDirectiveModifier {
    /// `top` — position above the reference, centered.
    case top
    /// `top-start` — position above the reference, aligned to the start.
    case topStart
    /// `top-end` — position above the reference, aligned to the end.
    case topEnd
    /// `bottom` — position below the reference, centered.
    case bottom
    /// `bottom-start` — position below the reference, aligned to the start.
    case bottomStart
    /// `bottom-end` — position below the reference, aligned to the end.
    case bottomEnd
    /// `left` — position to the left of the reference, centered.
    case left
    /// `left-start` — position to the left of the reference, aligned to the start.
    case leftStart
    /// `left-end` — position to the left of the reference, aligned to the end.
    case leftEnd
    /// `right` — position to the right of the reference, centered.
    case right
    /// `right-start` — position to the right of the reference, aligned to the start.
    case rightStart
    /// `right-end` — position to the right of the reference, aligned to the end.
    case rightEnd
    /// `fixed` — use `position: fixed` (escapes `overflow: hidden` containers).
    case fixed
    /// `offset.N` — spacing in pixels between the anchored and reference elements.
    case offset(Int)
    /// `noflip` — don't auto-flip when there's no room in the chosen direction.
    case noflip
    /// `no-style` — don't apply positioning styles; access them via `$anchor.x` / `$anchor.y` in `x-bind:style`.
    case noStyle

    var rawValue: String {
        switch self {
        case .top: "top"
        case .topStart: "top-start"
        case .topEnd: "top-end"
        case .bottom: "bottom"
        case .bottomStart: "bottom-start"
        case .bottomEnd: "bottom-end"
        case .left: "left"
        case .leftStart: "left-start"
        case .leftEnd: "left-end"
        case .right: "right"
        case .rightStart: "right-start"
        case .rightEnd: "right-end"
        case .fixed: "fixed"
        case .offset(let value): "offset.\(value)"
        case .noflip: "noflip"
        case .noStyle: "no-style"
        }
    }
}
