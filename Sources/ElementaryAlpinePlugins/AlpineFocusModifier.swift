public enum FocusModifier {
    case inert
    case noscroll
    case noreturn
    case noautofocus

    var rawValue: String {
        switch self {
        case .inert: "inert"
        case .noscroll: "noscroll"
        case .noreturn: "noreturn"
        case .noautofocus: "noautofocus"
        }
    }
}
