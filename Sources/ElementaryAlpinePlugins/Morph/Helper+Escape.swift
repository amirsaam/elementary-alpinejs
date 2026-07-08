import Foundation

/// Escapes a raw HTML string for use inside a JavaScript template literal (`` ` ``).
/// Backslash, backtick, `${`, and `</script>` are escaped to prevent injection.
/// Escapes a raw string for use inside a single-quoted JavaScript string literal.
/// Backslash and single quote are escaped to prevent broken or injected JS.
internal func escapeForJSString(_ raw: String) -> String {
    raw
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "'", with: "\\'")
}

internal func escapeForTemplateLiteral(_ rawHtml: String) -> String {
    rawHtml
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "`", with: "\\`")
        .replacingOccurrences(of: "${", with: "\\${")
        .replacingOccurrences(of: "</script>", with: "<\\/script>")
}
