import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineMorphBetweenTests: XCTestCase {
    func testBasicSetupMorphBetween() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-basic.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click"
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testLookaheadOption() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-lookahead.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                options: { .lookahead() }
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testKeyOption() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-key.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                options: { .key { "(el) => el.id" } }
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testAllHooks() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-all-hooks.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                options: {
                    .updating { "console.log('u')" }
                        .updated { "console.log('d')" }
                        .removing { "console.log('r')" }
                        .removed { "console.log('rm')" }
                        .adding { "console.log('a')" }
                        .added { "console.log('ad')" }
                        .key { "(el) => el.id" }
                        .lookahead()
                }
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testJsCommand() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-jscommand.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                li { "default" }
            },
            expected
        )
    }

    func testJsCommandWithOptions() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-jscommand-options.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                li { "default" }
            },
            expected
        )
    }

    func testEmptyJsCommandUsesStaticTemplate() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-empty-jscommand.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                jsCommand: { "" }
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testLookaheadFalseNotIncluded() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-lookahead-false.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click",
                options: { .lookahead(false) }
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testNoTriggerMinimalOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-notrigger-minimal.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                startMarker: "<!--start-->",
                endMarker: "<!--end-->"
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testNoTriggerOptionsOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-notrigger-options.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                options: { .added { "console.log('added')" } }
            ) {
                li { "new" }
            },
            expected
        )
    }

    func testNoTriggerJsCommandOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-notrigger-jscommand.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                jsCommand: { "const html = fetch('/api/list').then(r => r.text())" }
            ) {
                li { "default" }
            },
            expected
        )
    }

    func testNoTriggerFullOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-notrigger-full.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                options: { .lookahead() },
                jsCommand: { "const html = fetch('/api/list').then(r => r.text())" }
            ) {
                li { "default" }
            },
            expected
        )
    }

    func testNoTriggerJsCommandWithAwait() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-notrigger-jscommand-with-await.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                li { "default" }
            },
            expected
        )
    }

    func testNoTriggerFullWithAwait() throws {
        let expected = try String(contentsOf: fixtureURL("morphbetween-notrigger-full-with-await.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorphBetween(
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                li { "default" }
            },
            expected
        )
    }

    func testHTMLEscapingBacktick() {
        let html = renderToString {
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click"
            ) {
                li { "with `backtick`" }
            }
        }
        XCTAssertTrue(html.contains(#"\`backtick\`"#))
    }

    func testHTMLEscapingDollarBrace() {
        let html = renderToString {
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click"
            ) {
                li { "${var}" }
            }
        }
        XCTAssertTrue(html.contains(#"\${var}"#))
    }

    func testHTMLEscapingBackslash() {
        let html = renderToString {
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click"
            ) {
                li { "back\\slash" }
            }
        }
        XCTAssertTrue(html.contains("back\\\\slash"))
    }

    func testScriptTagEscaping() {
        let html = renderToString {
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click"
            ) {
                li { "safe content" }
            }
        }
        let outerScriptTags = html.components(separatedBy: "</script>").count - 1
        XCTAssertEqual(outerScriptTags, 1, "Should have exactly one outer </script> tag, not multiple")
    }

    func testScriptTagEscapingInContent() {
        let html = renderToString {
            setupMorphBetween(
                trigger: "#btn",
                startMarker: "<!--start-->",
                endMarker: "<!--end-->",
                event: "click"
            ) {
                li {
                    script { "evil()" }
                    "extra"
                }
            }
        }
        XCTAssertTrue(html.contains("<\\/script>"), "Inner </script> in content must be escaped to <\\/script>")
        let outerScriptTags = html.components(separatedBy: "</script>").count - 1
        XCTAssertEqual(outerScriptTags, 1, "Only the outer script tag's </script> should remain unescaped")
        XCTAssertTrue(html.contains("evil()"), "Inner script body should be preserved verbatim")
    }
}
