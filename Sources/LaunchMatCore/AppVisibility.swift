import Foundation

// 集中管理启动台默认过滤规则，避免误伤可独立使用的辅助应用。
public enum AppVisibility {
    public static func excludes(identifier: String, backgroundOnly: Bool,
                                explicitlyHidden: Bool, systemApp: Bool) -> Bool {
        if backgroundOnly || explicitlyHidden { return true }
        guard systemApp else { return false }
        if identifier == "com.apple.apps.launcher" { return true }
        // 新版入口存在不代表可用，保留原版 Siri 供用户选择。
        return false
    }
}
