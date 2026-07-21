# AGENTS.md

AI contribution guidelines for `elementary-alpine`.

## Project

`elementary-alpine` provides type-safe HTML attributes for [AlpineJS](https://alpinejs.dev/) directives, following [`elementary`](https://github.com/elementary-swift/elementary) and [`elementary-htmx`](https://github.com/elementary-swift/elementary-htmx). Built against Alpine.js **v3.15.12** (consumers include the runtime themselves).

Two products:
- `ElementaryAlpine` — 18 core directives, `registerGlobal`, `setupAlpine`
- `ElementaryAlpinePlugins` — 9 official plugins (Mask, Intersect, Resize, Persist, Focus, Collapse, Anchor, Sort, Morph; 8 with source packages, Persist is CDN-only — `$persist(...)` is used inline in JS strings)

## Dependency chain

`elementary-alpine → elementary`

SPM resolves transitively. Do not declare `elementary` as a direct dependency in consumer `Package.swift` files.

## Commands

```bash
swift test                                         # 196 tests, ~0.1s
swift test --filter EventHandlingTests             # single test class
swift test --parallel                               # parallel execution
swift build --build-tests                           # CI build
swift package clean                                 # stale .build fix
```

### Swift format

Config: `.swift-format` — line length 140, 4-space indent, trailing commas in collections.

```bash
swift-format lint --strict --recursive Sources/ Tests/   # local lint (strict + recursive)
swift-format format --recursive Sources/ Tests/          # auto-fix
```

CI runs `swift format lint -prs .` (different flags — CI uses `swift format`, local uses `swift-format`).

Lint must pass before committing.

## Architecture

### Source (`Sources/ElementaryAlpine/`)

- `AlpineJS.swift` — `setupAlpine()` entry point, `HTMLAttribute.x` namespace, `AlpinePlugin` protocol
- `AlpineModifier.swift` — `AlpineDirectiveModifier` protocol + `alpineDirective` helpers
- `Directives/` — 18 per-directive files (`AlpineDirective+Data.swift`, `AlpineDirective+On.swift`, etc.)
- `Globals/` — `AlpineGlobals` enum + `registerGlobal` builder
- `Helper+Escape.swift` — `escapeForJSString` / `escapeForTemplateLiteral` (shared across targets)

### Plugins (`Sources/ElementaryAlpinePlugins/`)

- `AlpinePluginModifier.swift` — `AlpinePluginDirectiveModifier` protocol + `alpinePluginDirective` helpers
- `Anchor/`, `Collapse/`, `Focus/`, `Intersect/`, `Mask/`, `Resize/`, `Sort/` — one directory per plugin with `HTMLAttribute+Alpine<Plugin>.swift` (directive) + `Modifier+<Plugin>.swift` (enum)
- `Morph/` — `setupMorph()`, `setupMorphBetween()`, `MorphOptions` builder

### Tests (`Tests/`)

- `ElementaryAlpineTests/` — mirrors `Sources/ElementaryAlpine/`
- `ElementaryAlpinePluginsTests/<Plugin>/` — mirrors `Sources/ElementaryAlpinePlugins/`
- `TestUtilities/` — `HTMLAssertEqual`, `fixtureURL`, `renderToString`

Plugin target has **no compile-time dependency** on `ElementaryAlpine` — both only depend on `Elementary`. The Alpine.js runtime link happens via CDN plugin scripts hooking into core.

Two separate modifier protocols (same shape, different targets):
- `AlpineDirectiveModifier` in `ElementaryAlpine` (core directives)
- `AlpinePluginDirectiveModifier` in `ElementaryAlpinePlugins` (plugin directives)

## Key patterns

- Directives are free functions on `HTMLAttribute.x` (`data()`, `on()`, `show()`) — users call `div(.x.data(...))` to compose
- Plugins are free functions on `HTMLAttribute.x<Plugin>` (`xMask.pattern()`, `xIntersect.intersect()`)
- Modifiers are typed enums (`OnModifier`, `SortModifier`) — never raw strings
- `setupAlpine()` emits `<script>` tags for the CDN runtime — plugins load before core
- `setupMorph()` / `setupMorphBetween()` return raw JS strings for inline use
- Persist has no directive — use `$persist(...)` as a JS string in `x-data` values

## File Naming Convention

Extensions use `<Type>+<Name>.swift`. The `+` means "this file extends the prefix type":
- `AlpineDirective+Data.swift` extends `AlpineDirective`
- `Modifier+Anchor.swift` extends the `Modifier` namespace
- `Helper+MorphOptions.swift` adds helpers to `MorphOptions`

The **modifier enum co-locates** in the same file as its directive factory (e.g., `OnModifier` lives in `AlpineDirective+On.swift`).

## Modifier API

An enum with `rawValue: String`, paired with a `modifiers:` array parameter:

```swift
public enum OnModifier { case prevent, .stop, /* ... */ .debounce(Int) }
div(.x.on("click", "count++", modifiers: [.prevent, .debounce(500)]))
```

## Swift Keyword Escapes

| HTML | Swift | Raw value |
|------|-------|-----------|
| `x-init` | `.setup` | `x-init` |
| `x-for` | `.loop` | `x-for` |
| `x-if` | `.when` | `x-if` |

HTML output is unchanged.

## Key APIs

```swift
// Globals — action is a trailing closure (NOT a String)
public func registerGlobal(
    _ kind: AlpineGlobals,        // .data | .store | .bind
    on: String,
    action: () -> String          // trailing closure
) -> some HTML

// Setup — emits CDN <script> tags, plugins first then Alpine core
public func setupAlpine(
    version: String = "3.15.12",
    plugins: [AlpinePlugin] = []   // empty = Alpine core only
) -> some HTML
```

Plugins with no directive surface ship separately:
- **Persist** — no `x-persist`; use `$persist(...)` as a JS string in `x-data` values.
- **Morph** — no `x-morph`; ships `setupMorph(...)` / `setupMorphBetween(...)` with a `MorphOptions` struct (in `Helper+MorphOptions.swift`).

## Versioning

**Epoch SemVer** ([antfu.me/posts/epoch-semver](https://antfu.me/posts/epoch-semver)) with `100×` multiplier: `Epoch.Major.(Minor×100 + Patch)`.

- `Major` bump → breaking change
- `Minor×100 + Patch` encodes minor (×100) + patch (0–99)
- Tag format: `chore: tag 0.X.YYY` (empty commit + tag)

## Build Quirks

- **Swift 6.1** with `StrictConcurrency=complete` enabled — concurrency violations are real errors.
- `ExistentialAny` upcoming feature is also enabled globally.
- macOS only (CI uses `macos-latest`); no Linux support tested.
- If you see `multiple producers` errors, run `swift package clean` — stale `.build` cache from a folder move.

## Testing

- `Tests/ElementaryAlpinePluginsTests/<Plugin>/` mirrors the source structure.
- `Tests/TestUtilities/Utilities.swift` holds the `HTMLAttributeAssertEqual` helper.
- Verify both: rendered HTML matches AlpineJS expectations AND modifier chaining works for value types.
- **Snapshot tests** use `fixtureURL("name.html")` to load expected HTML from `SnapshotFixtures/` directories, compared via `HTMLAssertEqual`. To add a snapshot: write the expected HTML file first, then write the test that reads it.
- There's a **separate `TestUtilities` target** in `Package.swift` (lives at `Tests/TestUtilities/`, depends only on `Elementary`).

## Conventions

- `public` for all public API surface.
- `///` doc comments required on all public API (morph-plugin style: one-line summary + `**Generated HTML:**` + `**Example:**` + optional `**Notes:**`).
- **No inline comments** unless documenting non-obvious behavior.
- Use typed modifier enums — do not hardcode raw strings for modifiers.

## Coding standards

- Follow latest APIs from `elementary`.
- Use `HTMLAttribute<Tag>` (not the old unparameterized `HTMLAttribute`).

## Commit Guidelines

Conventional commits: `feat(scope):`, `fix(scope):`, `refactor(scope):`, `test(scope):`, `docs(scope):`, `chore(scope):`.

Pre-merge: `swift format lint -prs .` + `swift test`.

### Commit cycle

When implementing or refactoring a component/directive, follow this 3-step cycle:

1. `feat(scope):` or `refactor(scope):` — implement or refactor the component
2. `test(scope):` — add or update tests
3. `docs(scope):` — update AGENTS.md, README, or doc comments if needed

Use `fix(scope):` for bug fixes and `chore(scope):` for maintenance tasks (dependencies, CI, tooling).

## Do not

- Do not start implementing, refactoring, or changing code without first reading the relevant docs in the upstream packages (`elementary`, Alpine.js).
- Do not commit without user review and approval.
- Do not use deprecated APIs from `elementary`.
- Do not auto-commit or push — always wait for explicit user confirmation.

## CI/CD

- `.github/workflows/ci.yaml` — `swift build --build-tests` + `swift test` on `macos-latest`
- `.github/workflows/format.yaml` — `swift format lint -prs .` on `**.swift` changes
- `.github/workflows/validate-snapshots.yaml` — validates JS syntax in plugin HTML snapshot fixtures using Node.js `new Function()`

## Dependencies

- `elementary` ≥ 0.8.0 (underlying HTML rendering library)
- No other external dependencies

## Upstream docs

- [Alpine.js](https://alpinejs.dev/) — the JavaScript framework this package wraps
- [elementary](https://github.com/elementary-swift/elementary) — the Swift HTML rendering framework
