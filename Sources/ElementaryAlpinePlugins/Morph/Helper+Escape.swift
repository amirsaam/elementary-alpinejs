import Foundation

/// Escapes a raw HTML string for use inside a JavaScript template literal (`` ` ``).
/// Backslash, backtick, `${`, and `</script>` are escaped to prevent injection.
internal func escapeForTemplateLiteral(_ rawHtml: String) -> String {
    rawHtml
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "`", with: "\\`")
        .replacingOccurrences(of: "${", with: "\\${")
        .replacingOccurrences(of: "</script>", with: "<\\/script>")
}
