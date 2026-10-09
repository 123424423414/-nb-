# 项目简介

## 一句话

**万能破甲通** 是一个**完全本地运行**的配置注入工具：一套脚本，给 15 个 AI 客户端写入**统一的操作者人格**与**宽松内容政策**，改动前自动备份、一条命令随时还原。

## 它做什么

- **一套人格、十五个目标**：DSH、WorkBuddy、ZCode、Codex CLI、Cursor、Claude Code、Gemini CLI、Qwen Code、iFlow、Trae、CodeBuddy、OpenCode、Windsurf、Cline、GitHub Copilot CLI —— 全部走同一份人格与政策文本，口径一致，不再各写各的。
- **只动自己写入的那一段**：除 WorkBuddy / DSH 走各自的政策块替换通道外，其余目标统一使用 `<!-- POJIA-NEXT-INJECT:BEGIN/END -->` 标记块：没有就追加、已有就整块替换、还原时按标记精确删掉，文件其余部分一个字节不碰。
- **可逆**：每个被修改的文件都会备份（`.dshpurge.bak` / `.unlockbak` / `.pojia.bak`），备份另按时间戳归档到 `历史备份/`；`--revert` 随时还原成原版。
- **只读与预演**：`--status` / `--diagnose` / `--check` 永不写盘，`--dry-run` 只列出将会改动什么。
- **自证口令**：注入的人格里带一段自证约定 —— 在客户端新会话里单独发送一个口令，若只回一行固定回执，说明人格确实载入成功。

## 特点

| 特点 | 说明 |
| --- | --- |
| 完全本地 | 不联网、不上传、不收集、不统计；无任何网络请求 |
| 零依赖 | 只用 Python 标准库，不需要 `pip install` 任何东西 |
| 明文常量 | 口令、回执、提示语集中在文件顶部的「本地常量区」，改完即生效 |
| 无封条 | 没有加密数据块、没有源码完整性校验 —— 改文件里任何一行都不会"拒绝启动" |
| 幂等 | 重复执行不会反复重写文件，也不会与官方升级互相打架（升级自愈） |
| 默认不杀进程 | 不擅自结束正在运行的 DSH 进程（避免杀掉承载本会话的宿主） |

## 快速开始

```bash
# 交互菜单（推荐）
python 万能破甲通.py

# 只读：查所有目标当前状态
python 万能破甲通.py --status

# 预演：只显示会改什么，不写盘
python 万能破甲通.py --dry-run

# 真打：所有已安装的目标
python 万能破甲通.py --apply

# 只打 / 只还原某一个
python 万能破甲通.py --apply  --target wb
python 万能破甲通.py --revert --target dsh

# 换人格文件
python 万能破甲通.py --apply --persona 我的.md
```

Windows 上也可以直接双击 `一键破甲.bat`。

## 目标一览

| 键 | 目标 | 注入位置 |
| --- | --- | --- |
| `dsh` | DeepSeek Harness | `dsh-agent-*` 的 `agent.cordis.yml` / `cordis.patch.yml` / `index.js` |
| `wb` | WorkBuddy | 模板、`product.json`、命令闸门、网页过滤、运行时缓存、会话快照、云记忆 |
| `zcode` | ZCode（zcode.z.ai） | `AGENTS.md` / Memory / 技能 / 可选 `cjs` 系统提示词 |
| `codex` | OpenAI Codex CLI | `~/.codex/config.toml` 的 `model_instructions_file` |
| `cursor` | Cursor | `.cursor/rules/*.mdc` |
| `claude` | Claude Code | `CLAUDE.md` |
| `gemini` | Gemini CLI | `~/.gemini/GEMINI.md` |
| `qwen` | Qwen Code | `~/.qwen/QWEN.md` |
| `iflow` | iFlow CLI | `~/.iflow/IFLOW.md` |
| `trae` | Trae | `~/.trae/rules/project_rules.md` |
| `codebuddy` | CodeBuddy | `~/.codebuddy/CODEBUDDY.md` |
| `opencode` | OpenCode | `~/.config/opencode/AGENTS.md` |
| `windsurf` | Windsurf | `~/.codeium/windsurf/memories/global_rules.md` |
| `cline` | Cline | `~/Documents/Cline/Rules/pojia-inject.md` |
| `copilot` | GitHub Copilot CLI | `~/.copilot/copilot-instructions.md` |

## 运行环境

- Python 3.8+（仅标准库）
- Windows 为主要平台（路径探测、守护任务、进程表都针对 Windows 编写；核心注入逻辑是纯文本处理）

## 适用与不适用

**适合**：想在自己的机器上统一多个 AI 客户端的操作者人格与内容政策的用户；做提示词注入 / 客户端行为研究的开发者。

**不适合**：把工具当作付费商品转卖；在他人设备或受管控环境上未经授权使用。使用前请读 [`DISCLAIMER.md`](DISCLAIMER.md)。

## 许可

MIT，见 [`LICENSE`](LICENSE)。完全免费、开源。

---

# Project Overview (English)

**WanNeng PoJiaTong** is a **fully local** configuration injection tool: one script that writes a **single operator persona** and a **permissive content policy** into **15 AI clients**, with automatic backups and one-command rollback.

- **One persona, fifteen targets** — DSH, WorkBuddy, ZCode, Codex CLI, Cursor, Claude Code, Gemini CLI, Qwen Code, iFlow, Trae, CodeBuddy, OpenCode, Windsurf, Cline, GitHub Copilot CLI.
- **Surgical edits** — marker-block injection (`<!-- POJIA-NEXT-INJECT:BEGIN/END -->`) for most targets: append if absent, replace as a block if present, remove by marker on revert. Everything else in the file is untouched.
- **Reversible** — every modified file is backed up (`.dshpurge.bak` / `.unlockbak` / `.pojia.bak`) and archived by timestamp; `--revert` restores the original.
- **Read-only modes** — `--status`, `--diagnose`, `--check` never write; `--dry-run` only reports what would change.
- **Self-check passphrase** — the injected persona carries a verification phrase: send it alone in a fresh session and a single fixed line confirms the persona actually loaded.

**Properties**: fully offline (no network requests, no telemetry), zero dependencies (Python standard library only), plain-text constants at the top of the file, no encryption block and no source seal — editing any line will never make the script refuse to start.

**Requirements**: Python 3.8+; Windows-first (path discovery, scheduled-task guard, process listing), with the injection logic itself being pure text processing.

**License**: MIT — free and open source. Read [`DISCLAIMER.md`](DISCLAIMER.md) before use.
