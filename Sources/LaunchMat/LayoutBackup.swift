import AppKit
import LaunchMatCore
import UniformTypeIdentifiers

// 备份包含布局及网格尺寸，独立于日常自动保存文件。
private struct LayoutBackup: Codable {
    let version: Int
    let layout: PadLayout
    let columns: Int
    let rows: Int
}

extension LaunchpadModel {
    // 导出当前内存中的最新布局，避免防抖保存遗漏最后一次操作。
    func exportBackup() {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.json]
        panel.nameFieldStringValue = "Launchpad-backup.json"
        guard panel.runModal() == .OK, let url = panel.url else { return }
        do {
            let backup = LayoutBackup(version: 1, layout: layout, columns: gridSize.cols, rows: gridSize.rows)
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            try encoder.encode(backup).write(to: url, options: .atomic)
        } catch { NSAlert(error: error).runModal() }
    }

    // 先校验并保留恢复前快照，确认后才替换布局。
    func importBackup() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.json]
        panel.allowsMultipleSelection = false
        guard panel.runModal() == .OK, let url = panel.url else { return }
        do {
            let backup = try JSONDecoder().decode(LayoutBackup.self, from: Data(contentsOf: url))
            guard backup.version == 1, (3...12).contains(backup.columns), (2...8).contains(backup.rows) else {
                throw NSError(domain: "Launchpad", code: 1, userInfo: [NSLocalizedDescriptionKey: "备份版本或网格尺寸不受支持。"])
            }
            let alert = NSAlert()
            alert.messageText = "恢复备份将替换当前布局"
            alert.informativeText = "当前布局会保留为 layout.before-restore.json。"
            alert.addButton(withTitle: "恢复")
            alert.addButton(withTitle: "取消")
            guard alert.runModal() == .alertFirstButtonReturn else { return }
            let directory = Self.layoutURL.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
            try JSONEncoder().encode(layout).write(to: directory.appendingPathComponent("layout.before-restore.json"), options: .atomic)
            layout = backup.layout
            openFolder = nil
            currentPage = 0
            setGrid(GridSize(cols: backup.columns, rows: backup.rows))
            saveNow()
            refreshApps()
        } catch { NSAlert(error: error).runModal() }
    }
}
