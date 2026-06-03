# wechat-science-writer

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/RTCartist/wechat-science-writer)](https://github.com/RTCartist/wechat-science-writer/releases/latest)

Agent Skill：将论文、PDF、网页或参考公众号文章，整理为可发布的**中文微信公众号科研导读**（标题、结构、配图解读与 Markdown 排版）。

本仓库采用通用的 [Agent Skills](https://agentskills.io/) 格式（`SKILL.md` + 辅助资源），不绑定单一 IDE。

## 兼容的 Agent 环境

只要客户端支持加载 `SKILL.md` 技能目录，即可使用本 Skill，包括但不限于：

| 环境 | 安装位置（示例） |
| --- | --- |
| [Cursor](https://cursor.com) | `~/.cursor/skills/wechat-science-writer/`，或导入 Release 中的 `.skill` |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | `~/.claude/skills/wechat-science-writer/` 或项目内 `.claude/skills/` |
| [OpenAI Codex](https://openai.com/codex) | 按 Codex 文档将技能目录加入其 skills 配置 |
| 其他 Agent / Skills CLI | `npx skills add` 或复制整个技能目录到对应 skills 路径 |

各产品的技能目录名与导入方式可能略有差异，但核心均为：让 Agent 读取 `SKILL.md` 中的工作流与规范。

## 特性

- 参考既有推文，复刻标题公式、开篇节奏与栏目结构
- 从论文 / PDF / URL 核对题名、DOI、期刊、作者与关键实验数据
- 按「图 X｜……」规范撰写配图解读
- 输出可直接用于微信编辑器的 Markdown 草稿

## 安装

### 从 Release 安装

1. 打开 [Latest release](https://github.com/RTCartist/wechat-science-writer/releases/latest)
2. 下载 `wechat-science-writer-*.skill`
3. 在支持 `.skill` 导入的客户端中安装（如 Cursor）

### 使用 Skills CLI

```bash
npx skills add RTCartist/wechat-science-writer@wechat-science-writer -g -y
```

### 手动安装

将本仓库克隆或复制到所用 Agent 的 skills 目录，文件夹名保持为 `wechat-science-writer`，并确保包含 `SKILL.md`、`references/`、`templates/`。

## 使用

在对话中描述任务即可，例如：

```
按 Nature 子刊公众号风格，根据附件 PDF 写一篇科研导读，输出 Markdown。
```

```
模仿这篇参考推文撰写论文导读，并给出 3 个标题候选。
```

## 生成范例

以下为使用本 Skill 生成的公众号科研导读（Markdown 草稿，配图位置为占位符，发布前需插入论文配图）。

| 项目 | 内容 |
| --- | --- |
| 论文 | *Nature Electronics* — *A large-scale stretchable neuromorphic circuit for on-body edge computing* |
| DOI | [10.1038/s41928-026-01639-8](https://doi.org/10.1038/s41928-026-01639-8) |
| 完整文稿 | [examples/nature-electronics-stretchable-neuromorphic-wechat.md](examples/nature-electronics-stretchable-neuromorphic-wechat.md) |

**标题预览：**

> **[Nature Electronics]芝加哥大学等团队用可拉伸神经形态电路实现“贴身边缘计算”**

**导读节选：**

> 本文报道了一种大面积、本征可拉伸的神经形态电路……阵列密度最高可达每平方厘米 1 万颗器件，室颤波前检测与软件计算的匹配率超过 99.6%，心梗风险 MLP 推断平均准确率 83.5%。

## 目录说明

| 路径 | 说明 |
| --- | --- |
| `SKILL.md` | Skill 主指令 |
| `references/` | 参考推文风格分析表 |
| `templates/` | 文章结构模板 |
| `examples/` | 使用本 Skill 生成的公众号范例 |

## 许可证

本项目采用 [MIT](LICENSE) 许可证。
