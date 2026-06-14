# elementary-alpine

Type-safe [AlpineJS](https://alpinejs.dev/) attributes for [Elementary](https://github.com/elementary-swift/elementary).

## Status

🚧 **Pre-release (v0.x.x)** — under active development. Core directives will land in `v0.1.000`.

## Overview

This package provides Swift extensions for generating HTML with AlpineJS directives in a type-safe manner, following the patterns established by [elementary-htmx](https://github.com/elementary-swift/elementary-htmx).

## Requirements

- Swift 6.0+
- macOS 14+ / iOS 15+ / tvOS 17+ / watchOS 10+
- [Elementary](https://github.com/elementary-swift/elementary) ≥ 0.6.0

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/elementary-swift/elementary-alpine.git", from: "0.1.0")
]
```

Then add the products you need to your target:

```swift
.product(name: "ElementaryAlpine", package: "elementary-alpine")
```

## License

[Apache 2.0](./LICENSE)
