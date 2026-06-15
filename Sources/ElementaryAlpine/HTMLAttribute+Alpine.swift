import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS attributes.
    /// See the [AlpineJS reference](https://alpinejs.dev/) for more information.
    public enum x {}
}

extension HTMLAttribute.x {
    public static func data(_ value: String) -> HTMLAttribute {
        .init(name: "x-data", value: value)
    }

    public static func setup(_ value: String) -> HTMLAttribute {
        .init(name: "x-init", value: value)
    }

    public static func show(_ value: String, modifiers: [ShowModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-show", value: value)
        }
        return .init(name: "x-show.\(modifiers.map(\.rawValue).joined(separator: "."))", value: value)
    }

    public static func bind(_ attribute: String, _ value: String) -> HTMLAttribute {
        .init(name: "x-bind:\(attribute)", value: value)
    }

    public static func bind(_ value: String) -> HTMLAttribute {
        .init(name: "x-bind", value: value)
    }

    public static func bindClass(_ value: HTMLAttributeValue.Alpine.BindClass) -> HTMLAttribute {
        .init(name: "x-bind:class", value: value.rawValue)
    }

    public static func bindStyle(_ value: HTMLAttributeValue.Alpine.BindStyle) -> HTMLAttribute {
        .init(name: "x-bind:style", value: value.rawValue)
    }

    public static func on(_ event: String, _ value: String, modifiers: [OnModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-on:\(event)", value: value)
        }
        return .init(name: "x-on:\(event).\(modifiers.map(\.rawValue).joined(separator: "."))", value: value)
    }

    public static func text(_ value: String) -> HTMLAttribute {
        .init(name: "x-text", value: value)
    }

    public static func html(_ value: String) -> HTMLAttribute {
        .init(name: "x-html", value: value)
    }

    public static func model(_ value: String, modifiers: [ModelModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-model", value: value)
        }
        return .init(name: "x-model.\(modifiers.map(\.rawValue).joined(separator: "."))", value: value)
    }

    public static func loop(_ value: String) -> HTMLAttribute {
        .init(name: "x-for", value: value)
    }

    public static func transition(modifiers: [TransitionModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-transition", value: nil)
        }
        return .init(name: "x-transition.\(modifiers.map(\.rawValue).joined(separator: "."))", value: nil)
    }

    public static func transitionEnter(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:enter", value: value)
    }

    public static func transitionEnterStart(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:enter-start", value: value)
    }

    public static func transitionEnterEnd(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:enter-end", value: value)
    }

    public static func transitionLeave(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:leave", value: value)
    }

    public static func transitionLeaveStart(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:leave-start", value: value)
    }

    public static func transitionLeaveEnd(_ value: String) -> HTMLAttribute {
        .init(name: "x-transition:leave-end", value: value)
    }

    public static func effect(_ value: String) -> HTMLAttribute {
        .init(name: "x-effect", value: value)
    }

    public static var ignore: HTMLAttribute {
        .init(name: "x-ignore", value: nil)
    }

    public static func ref(_ value: String) -> HTMLAttribute {
        .init(name: "x-ref", value: value)
    }

    public static var cloak: HTMLAttribute {
        .init(name: "x-cloak", value: nil)
    }

    public static func teleport(_ value: String) -> HTMLAttribute {
        .init(name: "x-teleport", value: value)
    }

    public static func when(_ value: String) -> HTMLAttribute {
        .init(name: "x-if", value: value)
    }

    public static func id(_ value: String) -> HTMLAttribute {
        .init(name: "x-id", value: value)
    }

    public static func modelable(_ value: String) -> HTMLAttribute {
        .init(name: "x-modelable", value: value)
    }
}
