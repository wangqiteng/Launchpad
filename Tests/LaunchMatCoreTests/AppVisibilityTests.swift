import XCTest
@testable import LaunchMatCore

final class AppVisibilityTests: XCTestCase {
    private func excluded(_ id: String, system: Bool = true,
                          background: Bool = false, hidden: Bool = false) -> Bool {
        AppVisibility.excludes(identifier: id, backgroundOnly: background,
                               explicitlyHidden: hidden, systemApp: system)
    }

    func testSiriFallback() {
        XCTAssertFalse(excluded("com.apple.siri.launcher"))
        XCTAssertFalse(excluded("com.apple.campo"))
    }

    func testNormalToolsRemainVisible() {
        for id in ["com.apple.screenshot.launcher", "com.apple.exposelauncher",
                   "com.apple.backup.launcher", "com.apple.SystemProfiler"] {
            XCTAssertFalse(excluded(id))
        }
        XCTAssertFalse(excluded("local.clipboard", system: false))
    }

    func testExplicitExclusions() {
        XCTAssertTrue(excluded("com.apple.apps.launcher"))
        XCTAssertTrue(excluded("helper", system: false, background: true))
        XCTAssertTrue(excluded("helper", hidden: true))
    }
}
