import Foundation

/// Escapes a raw string for use inside a single-quoted JavaScript string literal.
/// Backslash and single quote are escaped to prevent broken or injected JS.
internal func escapeForJSString(_ raw: String) -> String {
    raw
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "'", with: "\\'")
}
