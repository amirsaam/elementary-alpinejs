import Elementary
import ElementaryAlpinePlugins
import TestUtilities
import XCTest

final class ElementaryAlpineMorphTests: XCTestCase {
    func testBasicSetupMorph() throws {
        let expected = try String(contentsOf: fixtureURL("morph-basic-setup.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "new" }
            },
            expected
        )
    }

    func testLookaheadOption() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .lookahead() }
            ) {
                div { "new" }
            }
        }
        XCTAssertTrue(html.contains("lookahead: true"))
    }

    func testKeyOption() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                options: { .key { "(el) => el.id" } }
            ) {
                ul { li { "a" } }
            }
        }
        XCTAssertTrue(html.contains("key: (el) => el.id"))
    }

    func testAllHooks() throws {
        let expected = try String(contentsOf: fixtureURL("morph-all-hooks.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#target",
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
                div { "new" }
            },
            expected
        )
    }

    func testChildrenOnlyAndSkipInHook() throws {
        let body = """
            if (el.dataset.frozen) {
                childrenOnly()
            }
            if (el.dataset.skip) {
                skip()
            }
            """
        let expected = try String(contentsOf: fixtureURL("morph-childrenonly-skip.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .updating { body } }
            ) {
                div { "new" }
            },
            expected
        )
    }

    func testHTMLEscapingBacktick() {
        let html = renderToString {
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "with `backtick`" }
            }
        }
        XCTAssertTrue(html.contains(#"\`backtick\`"#))
    }

    func testHTMLEscapingDollarBrace() {
        let html = renderToString {
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "${var}" }
            }
        }
        XCTAssertTrue(html.contains(#"\${var}"#))
    }

    func testHTMLEscapingBackslash() {
        let html = renderToString {
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "back\\slash" }
            }
        }
        XCTAssertTrue(html.contains("back\\\\slash"))
    }

    func testScriptTagEscaping() {
        let html = renderToString {
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "safe content" }
            }
        }
        let outerScriptTags = html.components(separatedBy: "</script>").count - 1
        XCTAssertEqual(outerScriptTags, 1, "Should have exactly one outer </script> tag, not multiple")
    }

    func testJsCommand() throws {
        let expected = try String(contentsOf: fixtureURL("morph-jscommand.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testJsCommandWithOptions() throws {
        let expected = try String(contentsOf: fixtureURL("morph-jscommand-options.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testEmptyJsCommandUsesStaticTemplate() throws {
        let expected = try String(contentsOf: fixtureURL("morph-empty-jscommand.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                jsCommand: { "" }
            ) {
                div { "new" }
            },
            expected
        )
    }

    func testNoOptionsProducesNoThirdArgument() throws {
        let expected = try String(contentsOf: fixtureURL("morph-no-third-arg.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "new" }
            },
            expected
        )
    }

    func testLookaheadFalseNotIncluded() throws {
        let expected = try String(contentsOf: fixtureURL("morph-lookahead-false.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .lookahead(false) }
            ) {
                div { "new" }
            },
            expected
        )
    }

    func testMinimalOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-minimal-overload.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "minimal" }
            },
            expected
        )
    }

    func testOptionsOnlyOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-options-only.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .added { "console.log('added')" } }
            ) {
                div { "new" }
            },
            expected
        )
    }

    func testJsCommandOnlyOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-jscommand-only.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testFullOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-full.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testNoTriggerMinimalOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-no-trigger.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(target: "#target") {
                div { "new" }
            },
            expected
        )
    }

    func testNoTriggerOptionsOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-notrigger-options.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                target: "#target",
                options: { .added { "console.log('added')" } }
            ) {
                div { "new" }
            },
            expected
        )
    }

    func testNoTriggerJsCommandOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-notrigger-jscommand.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                target: "#list",
                jsCommand: { "const html = fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testNoTriggerFullOverload() throws {
        let expected = try String(contentsOf: fixtureURL("morph-notrigger-full.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                target: "#list",
                options: { .lookahead() },
                jsCommand: { "const html = fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testNoTriggerJsCommandWithAwait() throws {
        let expected = try String(contentsOf: fixtureURL("morph-notrigger-jscommand-with-await.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                target: "#list",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testNoTriggerFullWithAwait() throws {
        let expected = try String(contentsOf: fixtureURL("morph-notrigger-full-with-await.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                target: "#list",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            },
            expected
        )
    }

    func testStaticFactoryUpdating() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-updating.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .updating { "log(el)" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryUpdated() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-updated.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .updated { "log(el)" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryRemoving() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-removing.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .removing { "log(el)" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryRemoved() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-removed.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .removed { "log(el)" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryAdding() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-adding.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .adding { "log(el)" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryAdded() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-added.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .added { "log(el)" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryKey() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-key.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .key { "(el) => el.id" } }) {
                div { "new" }
            },
            expected
        )
    }

    func testStaticFactoryLookahead() throws {
        let expected = try String(contentsOf: fixtureURL("morph-static-lookahead.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(trigger: "#btn", target: "#t", event: "click", options: { .lookahead() }) {
                div { "new" }
            },
            expected
        )
    }
}
