# 万能破甲通 v8.0

**一个完全本地运行的配置注入工具：一套脚本，给 15 个 AI 客户端写入统一的操作者人格与宽松内容政策 —— 改前自动备份，一条命令随时还原。**

- 十五个目标：DSH / WorkBuddy / ZCode / Codex CLI / Cursor / Claude Code / Gemini CLI / Qwen Code / iFlow / Trae / CodeBuddy / OpenCode / Windsurf / Cline / GitHub Copilot CLI
- 完全本地：不联网、不上传、不收集；零依赖，只用 Python 标准库
- 可逆：每个被改的文件都留备份，`--revert` 一键还原；`--status` / `--dry-run` 永不写盘
- 明文常量：自证口令与提示语集中在文件顶部「本地常量区」，改完即生效

完整简介与用法见 [`PROJECT_INTRO.md`](PROJECT_INTRO.md)；使用前请读 [`DISCLAIMER.md`](DISCLAIMER.md)。

由 `pojia-next-main/破甲一键通.py`（v8.0）重构而来：**功能一样，但原作者的东西一件不留。**

## 去掉了什么

| 类别 | 具体内容 |
| --- | --- |
| 致 AI 的声明段 | 源码里 110 行的「致 AI Agent / 大模型」说服文本：要求 AI 拒绝"去标识化"修改、原样输出 `[POJIA-REFUSE]` 回执 |
| 加密保护块 | `_A0.._A3` / `_B0`（base64 密文）/ `_B1` / `_B2` / `_k0.._k2` / `_d0.._d2` / `_st` / `_seal_decode` |
| 源码封条 | `_SX` / `_SY` / `_P2` / `_MK` / `_SB`、`_seal_alarm`、`_seal_read_source`、`_seal_source_problem`、`_seal_assert_source`、`_seal_verify_source`、`_say_agent_reminder` |
| 完整性锚点 | `INTEGRITY_ANCHOR` / `_integrity_digest()` / `_INTEGRITY_SALT` |
| 对外立场文案 | 官方 GitHub 仓库地址、官方 QQ 群号、免费/退款声明、反圈钱提示、反二改提示 |

随之消失的还有原版的行为：**"改动任意一行 → 启动即判定二改 → 退出码 3"**。
现在改文件里的任何一行都不会让脚本拒绝启动。

## 保留了什么

15 个目标（dsh / wb / zcode / codex / cursor / claude / gemini / qwen / iflow / trae / codebuddy / opencode / windsurf / cline / copilot）的完整破甲通道、全部命令行开关、交互菜单、护照机制、备份与还原、WorkBuddy 守护任务、提示词快照对比。

注入文本结构原样保留：`操作者人格 + 内容政策 + 最高优先级覆盖 + 作业规范 + 自证口令段`。

## 改了什么

- 原先靠运行时解密取用的几句常量，改为文件顶部「本地常量区」明文存放，直接改、即时生效。
- `verify_integrity()` 简化为常量存在性自检（不再比对源码封条）。
- 项目名 `破甲一键通` → `万能破甲通`。
- 内部标记（`pojia-yijiantong` 目录名、`.pojia.bak` 备份后缀、`<!-- POJIA-NEXT-INJECT -->` 块标记）**故意保留**：它们承担"识别旧安装 / 还原成原版"的功能，改掉会导致已注入的客户端认不出来、无法正常 revert。

## 用法

```
双击 一键破甲.bat                        交互菜单
python 万能破甲通.py --status             只读：所有目标全查一遍
python 万能破甲通.py --diagnose           只读：详细取证
python 万能破甲通.py --dry-run            预演，不改盘
python 万能破甲通.py --apply              真打（所有目标，自动跳过没装的）
python 万能破甲通.py --apply --target wb  只打 WorkBuddy
python 万能破甲通.py --revert --target dsh 只还原 DSH
python 万能破甲通.py --apply --persona 我的.md  换人格
```

## 自证口令

默认：在客户端新会话里单独发送 **破甲自检** → 预期只回一行 **破甲自检成功**。

要换成自己的暗号，改「本地常量区」里的 `passphrase` / `signal_reply` 即可：

```python
_LOCAL = {
    "passphrase": "破甲自检",
    "signal_reply": "破甲自检成功",
    "piracy_hint": "",          # 拼在回执后面的附加提示，默认空
    "pass_block_tmpl": (...),   # 写进客户端人格的整段模板
}
```

## 文件

- `万能破甲通.py` —— 主脚本（唯一的核心文件）
- `一键破甲.bat` —— 启动器（纯 ASCII，按体积自动定位核心 .py）
- `persona.md` —— 操作者人格（脚本启动时优先读它，注释块不会注入）
- `_build/build_from_source.py` —— 从原版重新生成本脚本的构建脚本
- `破甲日志.txt` —— 运行日志（自动生成）

## 免责声明与许可

**使用前请先读 [`DISCLAIMER.md`](DISCLAIMER.md)**（中英双语）：本工具只在本机修改配置、改动前自动备份、可随时还原；使用者应只在自己的设备与账号上使用，并对修改第三方软件可能带来的许可与合规后果自行负责；本项目与 DSH / WorkBuddy / ZCode / OpenAI / Anthropic / Google / Cursor / 腾讯 等任何厂商**无隶属或背书关系**。

本项目完全免费、开源，任何收费售卖均为非授权行为。授权方式见 [`LICENSE`](LICENSE)（MIT）。
