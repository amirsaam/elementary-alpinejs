public enum AnchorModifier {
    case top
    case topStart
    case topEnd
    case bottom
    case bottomStart
    case bottomEnd
    case left
    case leftStart
    case leftEnd
    case right
    case rightStart
    case rightEnd
    case fixed
    case offset(Int)
    case noflip
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
