# Launchpad

找回熟悉的 macOS 全屏启动台：大图标、分页、文件夹和桌面壁纸背景，也能用四指捏合快速打开。

这是基于 [LaunchMat](https://github.com/Jimmygplus/LaunchMat) 开发的免费开源版本，采用 GPL-3.0 许可证，与 Apple 官方 Launchpad 无隶属关系。

**[下载最新 DMG](https://github.com/wangqiteng/Launchpad/raw/refs/heads/main/dist/Launchpad-latest.dmg)** · **[反馈问题](https://github.com/wangqiteng/Launchpad/issues)**

> 当前安装包是 Apple Silicon 本地签名实验版，未经过 Apple 公证。主要在 macOS 27.2 上验证；四指手势接管使用私有系统接口，不保证所有系统版本或触控板均可用。

## 功能

| 功能 | 说明 |
| --- | --- |
| 全屏启动台 | 分页浏览、搜索、键盘导航和拖拽排序 |
| 壁纸背景 | 读取当前桌面壁纸，模糊并压暗；读取失败时使用备用渐变背景 |
| 文件夹 | 拖动应用重叠创建、重命名、拖入或拖出；数量不设人为上限，不支持嵌套 |
| 自定义网格 | 3–12 列、2–8 行 |
| 四指捏合 | 捏合打开、展开关闭；实验性接管系统捏合，减少双重响应和闪现 |
| 多种唤出方式 | 菜单栏、快捷键、触发角和开机启动 |
| 批量整理 | Command 多选，批量拖动、建文件夹和隐藏 |
| 长按抖动 | 长按约 0.55 秒进入编辑模式，点击 × 确认卸载 |
| 隐藏应用 | 隐藏不常用入口，并可在设置中恢复 |
| 布局备份 | 自动保存布局、手动导出和恢复；恢复前保存当前布局快照 |
| 默认筛选 | 排除明确标记的后台/隐藏组件及系统 Apps 入口，保留原版 Siri和常用系统工具 |

## 安装与更新

1. 下载并打开 [Launchpad-latest.dmg](https://github.com/wangqiteng/Launchpad/raw/refs/heads/main/dist/Launchpad-latest.dmg)。
2. 将 **Launchpad** 拖入 **Applications（应用程序）**。
3. 弹出 DMG，从“应用程序”打开 Launchpad，避免运行安装镜像中的副本。
4. 如果 macOS 阻止打开，在确认下载来自本仓库后，前往“系统设置 → 隐私与安全性”检查“仍要打开”选项。

更新时，先从菜单栏完全退出旧版，再替换应用。已有布局和隐藏设置保存在用户数据目录中，不需要重新整理。

当前 DMG 仅包含 Apple Silicon 构建。Intel 用户可以尝试从源码构建，但尚未验证。安装包的 SHA-256 校验值见 [dist/SHA256SUMS](dist/SHA256SUMS)。

## 使用方式

### 打开、搜索与退出

- 点击菜单栏图标，或按默认快捷键 **Shift + Command + 空格**打开启动台；快捷键可在设置中修改。
- 输入应用名称搜索，使用方向键和回车选择、启动应用。
- 点击空白处或按 Esc 返回；编辑状态或文件夹打开时，Esc 会先退出当前状态。
- 收起全屏界面后，Launchpad 仍在后台运行。要停止接管手势，请从菜单栏选择退出。

### 开启四指手势

1. 在 Launchpad 设置中选择四指/五指捏合。
2. 在“系统设置 → 隐私与安全性 → 辅助功能”中允许 Launchpad；如未生效，退出后重新启动。
3. 测试自动接管时，保持系统对应手势开启。
4. 用拇指加另外三指向内捏合打开，向外展开关闭。

接管器只在程序运行且手势监听成功时生效，不修改系统手势开关。退出程序后由系统继续处理事件。部分设备可能需要重新授权；遇到闪现、方向异常或无响应，可先使用快捷键/触发角，并提交问题反馈。

目前已获得 macOS 27.2 上消除系统闪现的实机反馈；展开关闭、退出恢复及更多设备组合仍需持续验证。

### 文件夹与批量操作

- 将一个应用拖到另一个应用图标中央，稍停后松手创建文件夹。
- 点击文件夹名称重命名，拖动图标调整顺序；将应用拖出文件夹可移回主网格。
- 按住 **Command** 点击多个应用，然后一起拖动，或通过右键菜单批量建文件夹、隐藏。
- 长按图标约 **0.55 秒**，或按住 **Option**，进入抖动状态。点击 **×** 后按提示确认卸载；受保护的系统应用不会显示卸载按钮。

“隐藏”只是从启动台移除入口，不会卸载应用。系统功能可能因地区、账户或下载状态不可用，可手动隐藏，不会仅因显示为系统应用就自动删除。

### 设置与备份

在菜单栏或启动台的 **…** 菜单打开设置，可以调整网格、触发角、开机启动以及隐藏应用。

在界面设置中点击“导出布局备份”保存 JSON 文件，点击“恢复布局备份”导入。恢复会替换当前布局，并先保留恢复前快照。

- 布局：`~/Library/Application Support/Launchpad/layout.json`
- 恢复前快照：同目录下的 `layout.before-restore.json`

壁纸背景是经过处理的静态图像，不会逐帧播放动态壁纸。布局备份含应用路径，分享备份前请检查其中的信息。

## 从源码构建

需要 macOS 14+、Swift 5.10+。完整单元测试需要安装 Xcode；仅 Command Line Tools 可能无法提供 XCTest。

```sh
git clone https://github.com/wangqiteng/Launchpad.git
cd Launchpad
./build.sh
open build/Launchpad.app
```

输出为 `build/Launchpad.app`，采用本地签名。内部 Swift target 仍沿用 `LaunchMat` 名称。

```sh
swift test
.build/release/LaunchMat --selftest
```

内置交互自检使用临时布局，不保存应用排列；它不会真正卸载应用。当前版本已通过本机 Release 构建、交互自检、应用签名和 DMG 校验，并对文件夹展开结果做过渲染检查。本地环境未运行完整 XCTest 套件。

## 已知限制与反馈

- 四指手势依赖私有系统接口，macOS 更新可能改变行为；其他系统版本和 Intel 尚未完整验证。
- 文件夹不支持嵌套；“不设数量上限”不代表无限容量或性能保证。
- 未完成所有卸载残留场景的验证，受权限保护的数据可能需要手动处理。
- 上游发布脚本和历史说明保留供参考，本分支当前不提供 Apple 公证发行流程。

[提交 Issue](https://github.com/wangqiteng/Launchpad/issues) 时，请附 macOS 版本、芯片类型、触控板类型、复现步骤；截图前请遮挡私人应用信息。

## 来源与许可证

基于 LaunchMat 提交 `9750b0179c0d37fd60568210ee545b3e9e4da036`，感谢原作者及贡献者。原项目说明见 [docs/UPSTREAM-README.md](docs/UPSTREAM-README.md)。本分支新增或调整了壁纸读取、布局备份、自定义网格、长按编辑、系统入口筛选、文件夹状态修复和实验性手势接管。

底层事件格式参考 [dockswipe](https://github.com/oomol-lab/dockswipe) 与 Apple IOHID 事件定义。项目遵循 [GPL-3.0](LICENSE)，修改和分发时请保留版权与许可证，并遵循相应源码提供要求。
