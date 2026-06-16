public enum SortModifier {
    case ghost

    var rawValue: String {
        switch self {
        case .ghost: "ghost"
        }
    }
}
