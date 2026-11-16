# Launchpad

原生 macOS 全屏启动台，基于 [LaunchMat](https://github.com/Jimmygplus/LaunchMat) 修改，保留 GPL-3.0 许可证。

## 安装

下载 [Launchpad-latest.dmg](dist/Launchpad-latest.dmg)，打开后将 Launchpad 拖到 Applications。更新前先完全退出旧版，再从“应用程序”启动。

当前 DMG 为 Apple Silicon 本机签名实验版，未经过 Apple 公证。校验值见 `dist/SHA256SUMS`。

## 功能

- 全屏分页、搜索、桌面壁纸模糊背景及渐变备用背景。
- 文件夹不设人为数量上限；不支持嵌套。
- 网格 3–12 列、2–8 行。
- 隐藏和恢复应用、Command 多选、批量拖动、建文件夹、隐藏。
- 布局导出与恢复；恢复前保存布局快照。
- 触发角、快捷键、四指捏合打开、展开关闭。
- 实验性系统捏合接管：运行时拦截已识别的 Dock 捏合事件，退出后移除监听，不修改系统手势偏好。

四指手势需要辅助功能权限；要测试自动接管，请保持系统对应手势开启。macOS 27 路径使用私有 HID 接口，系统升级可能影响兼容性。用户已在本机确认系统闪现消失；展开关闭、退出恢复及其他系统版本仍需进一步验收。

布局位于 `~/Library/Application Support/Launchpad/layout.json`。恢复前快照为同目录的 `layout.before-restore.json`。

## 构建与测试

```sh
./build.sh
# 生成 build/Launchpad.app
swift test
```

Swift 5.10+，macOS 14+；系统手势接管主要针对 macOS 27。完整单元测试需要 Xcode，本地仅 Command Line Tools 环境无法运行 XCTest。

本机已通过 Release 编译、安装包签名和镜像验证。背景修复前的内置交互自检全部通过；手势改造后另验证了所需动态符号存在、普通和未知事件放行。未声称完整回归测试通过。

## 来源

基于 LaunchMat 提交 `9750b0179c0d37fd60568210ee545b3e9e4da036`。原作者说明见 [docs/UPSTREAM-README.md](docs/UPSTREAM-README.md)，许可证见 [LICENSE](LICENSE)。

本分支修改包括应用名称和独立存储目录、Swift 5.10 兼容修正、网格范围、备份恢复、壁纸读取和实验性手势拦截。底层事件格式参考 [dockswipe](https://github.com/oomol-lab/dockswipe) 与 Apple IOHID 事件定义。内部构建 target 仍沿用 LaunchMat。

上游的发布脚本与发布文档保留作参考；本分支当前使用 `build.sh` 本地构建，不应直接按上游文档发布公证版本。
