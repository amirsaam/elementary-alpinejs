# AGENTS.md

AI contribution guidelines for `elementary-alpine`.

## Project

`elementary-alpine` provides type-safe HTML attributes for [AlpineJS](https://alpinejs.dev/) directives, following [`elementary`](https://github.com/elementary-swift/elementary) and [`elementary-htmx`](https://github.com/elementary-swift/elementary-htmx). Built against Alpine.js **v3.15.12** (consumers include the runtime themselves).

Two products:
- `ElementaryAlpine` — 18 core directives, `registerGlobal`, `setupAlpine`
- `ElementaryAlpinePlugins` — 9 official plugins (Mask, Intersect, Resize, Persist, Focus, Collapse, Anchor, Sort, Morph; 8 with source packages, Persist is CDN-only — `$persist(...)` is used inline in JS strings)

## Commands

```bash
swift test                                         # 196 tests, ~0.1s
swift test --filter EventHandlingTests             # single test class
swift test --parallel                               # parallel execution
swift build --build-tests                           # CI build
swift format lint -prs .                           # CI lint (parallel + recursive — flags required)
swift package clean                                 # stale .build fix
```

## Architecture

```
Sources/ElementaryAlpine/
├── AlpineJS.swift                           # HTMLAttribute.x namespace + AlpinePlugin + setupAlpine
├── AlpineModifier.swift                     # AlpineDirectiveModifier protocol + alpineDirective helpers
├── Directives/AlpineDirective+<Name>.swift   # 18 per-directive files (one per directive)
├── Globals/AlpineGlobals+Registry.swift      # AlpineGlobals enum + registerGlobal
├── Helper+Escape.swift                       # escapeForJSString / escapeForTemplateLiteral (shared across targets)
└── Magics/                                    # placeholder (empty; magics are JS strings in directive values)

Sources/ElementaryAlpinePlugins/
├── AlpinePluginModifier.swift               # AlpinePluginDirectiveModifier + alpinePluginDirective helpers
├── <Plugin>/
│   ├── HTMLAttribute+Alpine<Plugin>.swift   # directive factory
│   └── Modifier+<Plugin>.swift              # modifier enum (none for Mask)
└── Morph/
    ├── Helper+AlpineMorph.swift              # setupMorph factory
    ├── Helper+AlpineMorphBetween.swift       # setupMorphBetween factory
    └── Helper+MorphOptions.swift              # MorphOptions builder

Tests/TestUtilities/
└── Utilities.swift                          # HTMLAssertEqual, fixtureURL, renderToString

Tests/ElementaryAlpineTests/                    # mirrors Sources/ElementaryAlpine/
Tests/ElementaryAlpinePluginsTests/<Plugin>/    # mirrors Sources/ElementaryAlpinePlugins/
```

Plugin target has **no compile-time dependency** on `ElementaryAlpine` — both only depend on `Elementary`. The Alpine.js runtime link happens via CDN plugin scripts hooking into core.

Two separate modifier protocols (same shape, different targets):
- `AlpineDirectiveModifier` in `ElementaryAlpine` (core directives)
- `AlpinePluginDirectiveModifier` in `ElementaryAlpinePlugins` (plugin directives)

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

- **Swift 6.0** with `StrictConcurrency=complete` enabled — concurrency violations are real errors.
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
- Use enums (not structs) for modifier values.

## Commit Guidelines

- Prefix: `feat:`, `fix:`, `chore:`, `test:`, `docs:`, `refactor:` with target scope: `feat(core):`
- **Never auto-commit.** Show the diff and wait for user confirmation before each commit.
- **Never push without explicit user authorization.** Commits stay local.
- Pre-merge: `swift format lint -prs .` + `swift test`.

## CI/CD

- `.github/workflows/ci.yaml` — `swift build --build-tests` + `swift test` on `macos-latest`
- `.github/workflows/format.yaml` — `swift format lint -prs .` on `**.swift` changes
- `.github/workflows/validate-snapshots.yaml` — validates JS syntax in plugin HTML snapshot fixtures using Node.js `new Function()`

## Dependencies

- `elementary` ≥ 0.6.0 (underlying HTML rendering library)
- No other external dependencies
