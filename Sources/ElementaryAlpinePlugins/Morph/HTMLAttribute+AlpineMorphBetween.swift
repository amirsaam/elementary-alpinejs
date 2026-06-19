import Elementary
import Foundation

/// Generates the complete `<script>` element for an `Alpine.morphBetween` call.
/// `Alpine.morphBetween` morphs the range of DOM nodes between two marker
/// elements (typically HTML comment nodes), instead of a single root element.
/// When `trigger` is non-empty, the morph is wrapped in an `addEventListener`
/// block. When `trigger` is empty, the script emits the imperative call
/// directly, which runs once on page load.
private func generateMorphBetweenScript(
    startMarker: String,
    endMarker: String,
    trigger: String = "",
    event: String = "",
    options: () -> MorphOptions = { MorphOptions() },
    jsCommand: () -> String = { "" },
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    let rawHtml: String = returning().render()
    let escaped =
        rawHtml
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "`", with: "\\`")
        .replacingOccurrences(of: "${", with: "\\${")
        .replacingOccurrences(of: "</script>", with: "<\\/script>")

    let optionsJS = options().toJS()
    let optionsPart: String = optionsJS.isEmpty ? "" : ", \(optionsJS)"
    let command = jsCommand()
    let startRef = "findMorphMarker('\(startMarker)')"
    let endRef = "findMorphMarker('\(endMarker)')"
    let morphCall: String
    if command.isEmpty {
        morphCall = "Alpine.morphBetween(\(startRef), \(endRef), `\(escaped)`\(optionsPart))"
    } else {
        morphCall = "\(command)\nAlpine.morphBetween(\(startRef), \(endRef), html\(optionsPart))"
    }
    let helper = """
        const findMorphMarker = (marker) => {
            let el = document.querySelector(marker);
            if (el) return el;
            if (marker.startsWith('<!--') && marker.endsWith('-->')) {
                const text = marker.slice(4, -3).trim();
                const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_COMMENT);
                let node;
                while ((node = walker.nextNode())) {
                    if (node.nodeValue && node.nodeValue.trim() === text) return node;
                }
            }
            return null;
        };
        """
    if trigger.isEmpty {
        return HTMLRaw("<script>\n\(helper)\n\(morphCall)\n</script>")
    }
    let handler = "document.querySelector('\(trigger)').addEventListener('\(event)', async () => {\n    \(morphCall)\n})"
    return HTMLRaw("<script>\n\(helper)\n\(handler)\n</script>")
}

/// Generates a `<script>` that morphs the content between two marker
/// elements when the trigger element fires the given event.
///
/// Use this overload when you have a static HTML template and don't need
/// lifecycle hooks or dynamic HTML fetching.
///
/// **Generated HTML:**
/// ```html
/// <script>
/// document.querySelector(trigger).addEventListener(event, async () => {
///     Alpine.morphBetween(
///         document.querySelector(startMarker),
///         document.querySelector(endMarker),
///         `<html>`
///     )
/// })
/// </script>
/// ```
///
/// **Example:**
/// ```swift
/// setupMorphBetween(
///     trigger: "#refresh",
///     startMarker: "<!--list-start-->",
///     endMarker: "<!--list-end-->",
///     event: "click"
/// ) {
///     li { "new item" }
/// }
/// ```
public func setupMorphBetween(
    trigger: String,
    startMarker: String,
    endMarker: String,
    event: String,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        trigger: trigger,
        event: event,
        returning: returning
    )
}

/// Generates a `<script>` that morphs the content between two marker
/// elements with lifecycle hook options when the trigger fires.
///
/// **Generated HTML:**
/// ```html
/// <script>
/// document.querySelector(trigger).addEventListener(event, async () => {
///     Alpine.morphBetween(
///         document.querySelector(startMarker),
///         document.querySelector(endMarker),
///         `<html>`,
///         { ...options }
///     )
/// })
/// </script>
/// ```
public func setupMorphBetween(
    trigger: String,
    startMarker: String,
    endMarker: String,
    event: String,
    options: () -> MorphOptions,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        trigger: trigger,
        event: event,
        options: options,
        returning: returning
    )
}

/// Generates a `<script>` that fetches HTML dynamically and morphs the
/// content between two marker elements when the trigger fires.
///
/// The `jsCommand` closure must assign the HTML string to a variable named `html`.
public func setupMorphBetween(
    trigger: String,
    startMarker: String,
    endMarker: String,
    event: String,
    jsCommand: () -> String,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        trigger: trigger,
        event: event,
        jsCommand: jsCommand,
        returning: returning
    )
}

/// Generates a `<script>` with the full set of options: lifecycle hooks,
/// element identity (`.key`), `.lookahead`, and a dynamic JS pre-command.
public func setupMorphBetween(
    trigger: String,
    startMarker: String,
    endMarker: String,
    event: String,
    options: () -> MorphOptions,
    jsCommand: () -> String,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        trigger: trigger,
        event: event,
        options: options,
        jsCommand: jsCommand,
        returning: returning
    )
}

/// Generates a `<script>` that calls `Alpine.morphBetween` once on page load. No event listener is attached.
///
/// Use this overload when the morph should happen immediately on page load — for initial state
/// setup, pre-rendering, or one-time morphs. For morphs triggered by user actions, use an overload
/// with `trigger:` and `event:`.
///
/// - Parameters:
///   - startMarker: A CSS selector or HTML comment marker (`<!--...-->`) identifying the start of the range.
///   - endMarker: A CSS selector or HTML comment marker identifying the end of the range.
///   - returning: An `@HTMLBuilder` closure providing the new HTML to morph into the range.
///
/// **Generated HTML:**
/// ```html
/// <script>
/// const findMorphMarker = (marker) => { ... };
/// Alpine.morphBetween(findMorphMarker('<!--start-->'), findMorphMarker('<!--end-->'), `<li>new</li>`)
/// </script>
/// ```
///
/// **Example:**
/// ```swift
/// setupMorphBetween(
///     startMarker: "<!--start-->",
///     endMarker: "<!--end-->"
/// ) {
///     li { "initial" }
/// }
/// ```
public func setupMorphBetween(
    startMarker: String,
    endMarker: String,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        returning: returning
    )
}

/// Generates a `<script>` that calls `Alpine.morphBetween` with lifecycle hook options once on page load.
///
/// **Example:**
/// ```swift
/// setupMorphBetween(
///     startMarker: "<!--start-->",
///     endMarker: "<!--end-->",
///     options: { .added { "console.log('added', el)" } }
/// ) {
///     li { "initial" }
/// }
/// ```
public func setupMorphBetween(
    startMarker: String,
    endMarker: String,
    options: () -> MorphOptions,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        options: options,
        returning: returning
    )
}

/// Generates a `<script>` that runs a dynamic JS pre-command (e.g., a fetch) and then calls
/// `Alpine.morphBetween` once on page load.
///
/// The `jsCommand` closure must assign the resulting HTML string to a variable named `html`.
///
/// **Example:**
/// ```swift
/// setupMorphBetween(
///     startMarker: "<!--start-->",
///     endMarker: "<!--end-->",
///     jsCommand: { "const html = await fetch('/api/initial').then(r => r.text())" }
/// ) {
///     li { "loading..." }
/// }
/// ```
public func setupMorphBetween(
    startMarker: String,
    endMarker: String,
    jsCommand: () -> String,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        jsCommand: jsCommand,
        returning: returning
    )
}

/// Generates a `<script>` that runs a dynamic JS pre-command and calls `Alpine.morphBetween` with
/// lifecycle hook options once on page load. The most complete imperative form.
public func setupMorphBetween(
    startMarker: String,
    endMarker: String,
    options: () -> MorphOptions,
    jsCommand: () -> String,
    @HTMLBuilder returning: () -> some HTML
) -> some HTML {
    generateMorphBetweenScript(
        startMarker: startMarker,
        endMarker: endMarker,
        options: options,
        jsCommand: jsCommand,
        returning: returning
    )
}
