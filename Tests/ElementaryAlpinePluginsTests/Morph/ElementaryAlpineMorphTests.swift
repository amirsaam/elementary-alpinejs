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

    func testWithSingleOption() throws {
        let expected = try String(contentsOf: fixtureURL("morph-with-single-option.html"), encoding: .utf8)
        HTMLAssertEqual(
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .updating { "console.log(el)" } }
            ) {
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

    func testAllHooks() {
        let html = renderToString {
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
            }
        }
        XCTAssertTrue(html.contains("updating(el, toEl, childrenOnly, skip) { console.log('u') }"))
        XCTAssertTrue(html.contains("updated(el, toEl) { console.log('d') }"))
        XCTAssertTrue(html.contains("removing(el, skip) { console.log('r') }"))
        XCTAssertTrue(html.contains("removed(el) { console.log('rm') }"))
        XCTAssertTrue(html.contains("adding(el, skip) { console.log('a') }"))
        XCTAssertTrue(html.contains("added(el) { console.log('ad') }"))
        XCTAssertTrue(html.contains("key: (el) => el.id"))
        XCTAssertTrue(html.contains("lookahead: true"))
    }

    func testChildrenOnlyAndSkipInHook() {
        let body = """
            if (el.dataset.frozen) {
                childrenOnly()
            }
            if (el.dataset.skip) {
                skip()
            }
            """
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .updating { body } }
            ) {
                div { "new" }
            }
        }
        XCTAssertTrue(html.contains("childrenOnly()"))
        XCTAssertTrue(html.contains("skip()"))
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

    func testJsCommand() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            }
        }
        XCTAssertTrue(html.contains("const html = await fetch('/api/list').then(r => r.text())"))
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#list'), html)"))
    }

    func testJsCommandWithOptions() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            }
        }
        XCTAssertTrue(html.contains("const html = await fetch"))
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#list'), html, { lookahead: true })"))
    }

    func testEmptyJsCommandUsesStaticTemplate() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                jsCommand: { "" }
            ) {
                div { "new" }
            }
        }
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#target'), `<div>new</div>`)"))
        XCTAssertFalse(html.contains("const html"))
    }

    func testNoOptionsProducesNoThirdArgument() {
        let html = renderToString {
            setupMorph(trigger: "#btn", target: "#target", event: "click") {
                div { "new" }
            }
        }
        XCTAssertFalse(html.contains("undefined"))
    }

    func testLookaheadFalseNotIncluded() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .lookahead(false) }
            ) {
                div { "new" }
            }
        }
        XCTAssertFalse(html.contains("lookahead"))
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

    func testOptionsOnlyOverload() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#target",
                event: "click",
                options: { .added { "console.log('added')" } }
            ) {
                div { "new" }
            }
        }
        XCTAssertTrue(html.contains("added(el) { console.log('added') }"))
        XCTAssertFalse(html.contains("const html"))
    }

    func testJsCommandOnlyOverload() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            }
        }
        XCTAssertTrue(html.contains("const html = await fetch('/api/list').then(r => r.text())"))
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#list'), html)"))
        XCTAssertFalse(html.contains("lookahead"))
    }

    func testFullOverload() {
        let html = renderToString {
            setupMorph(
                trigger: "#btn",
                target: "#list",
                event: "click",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            }
        }
        XCTAssertTrue(html.contains("const html = await fetch"))
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#list'), html, { lookahead: true })"))
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

    func testNoTriggerOptionsOverload() {
        let html = renderToString {
            setupMorph(
                target: "#target",
                options: { .added { "console.log('added')" } }
            ) {
                div { "new" }
            }
        }
        XCTAssertTrue(
            html.contains(
                "Alpine.morph(document.querySelector('#target'), `<div>new</div>`, { added(el) { console.log('added') } })"
            )
        )
        XCTAssertFalse(html.contains("addEventListener"))
    }

    func testNoTriggerJsCommandOverload() {
        let html = renderToString {
            setupMorph(
                target: "#list",
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            }
        }
        XCTAssertTrue(html.contains("const html = await fetch('/api/list').then(r => r.text())"))
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#list'), html)"))
        XCTAssertFalse(html.contains("addEventListener"))
    }

    func testNoTriggerFullOverload() {
        let html = renderToString {
            setupMorph(
                target: "#list",
                options: { .lookahead() },
                jsCommand: { "const html = await fetch('/api/list').then(r => r.text())" }
            ) {
                div { "default" }
            }
        }
        XCTAssertTrue(html.contains("const html = await fetch"))
        XCTAssertTrue(html.contains("Alpine.morph(document.querySelector('#list'), html, { lookahead: true })"))
        XCTAssertFalse(html.contains("addEventListener"))
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
