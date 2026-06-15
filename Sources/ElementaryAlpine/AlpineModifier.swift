import Elementary

public enum OnModifier {
    case prevent
    case stop
    case once
    case capture
    case selfTarget
    case shift
    case ctrl
    case alt
    case meta
    case cmd
    case enter
    case escape
    case space
    case tab
    case capsLock
    case equal
    case period
    case comma
    case slash
    case up
    case down
    case left
    case right
    case window
    case document
    case outside
    case passive
    case passiveFalse
    case camel
    case dot
    case debounce(Int)
    case throttle(Int)

    var rawValue: String {
        switch self {
        case .prevent: "prevent"
        case .stop: "stop"
        case .once: "once"
        case .capture: "capture"
        case .selfTarget: "self"
        case .shift: "shift"
        case .ctrl: "ctrl"
        case .alt: "alt"
        case .meta: "meta"
        case .cmd: "cmd"
        case .enter: "enter"
        case .escape: "escape"
        case .space: "space"
        case .tab: "tab"
        case .capsLock: "caps-lock"
        case .equal: "equal"
        case .period: "period"
        case .comma: "comma"
        case .slash: "slash"
        case .up: "up"
        case .down: "down"
        case .left: "left"
        case .right: "right"
        case .window: "window"
        case .document: "document"
        case .outside: "outside"
        case .passive: "passive"
        case .passiveFalse: "passive.false"
        case .camel: "camel"
        case .dot: "dot"
        case .debounce(let ms): "debounce.\(ms)ms"
        case .throttle(let ms): "throttle.\(ms)ms"
        }
    }
}

public enum ModelModifier {
    case lazy
    case change
    case blur
    case enter
    case number
    case boolean
    case fill

    var rawValue: String {
        switch self {
        case .lazy: "lazy"
        case .change: "change"
        case .blur: "blur"
        case .enter: "enter"
        case .number: "number"
        case .boolean: "boolean"
        case .fill: "fill"
        }
    }
}

public enum ShowModifier {
    case important

    var rawValue: String {
        switch self {
        case .important: "important"
        }
    }
}

public enum TransitionModifier {
    public enum Origin {
        case top
        case bottom
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight

        var rawValue: String {
            switch self {
            case .top: "top"
            case .bottom: "bottom"
            case .left: "left"
            case .right: "right"
            case .topLeft: "top.left"
            case .topRight: "top.right"
            case .bottomLeft: "bottom.left"
            case .bottomRight: "bottom.right"
            }
        }
    }

    case opacity
    case scale(Int? = nil)
    case origin(Origin)
    case duration(Int)
    case delay(Int)

    var rawValue: String {
        switch self {
        case .opacity: "opacity"
        case .scale(let percentage): percentage.map { "scale.\($0)" } ?? "scale"
        case .origin(let value): "origin.\(value.rawValue)"
        case .duration(let ms): "duration.\(ms)ms"
        case .delay(let ms): "delay.\(ms)ms"
        }
    }
}
