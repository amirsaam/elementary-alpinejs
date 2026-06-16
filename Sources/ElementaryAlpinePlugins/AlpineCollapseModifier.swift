public enum CollapseModifier {
    case duration(Int)
    case min(Int)

    var rawValue: String {
        switch self {
        case .duration(let ms): "duration.\(ms)ms"
        case .min(let px): "min.\(px)px"
        }
    }
}
