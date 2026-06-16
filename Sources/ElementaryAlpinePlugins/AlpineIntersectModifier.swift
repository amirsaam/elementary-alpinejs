public enum IntersectModifier {
    case once
    case half
    case full
    case threshold(Int)
    case margin(String)

    var rawValue: String {
        switch self {
        case .once: "once"
        case .half: "half"
        case .full: "full"
        case .threshold(let value): "threshold.\(value)"
        case .margin(let value): "margin.\(value)"
        }
    }
}
