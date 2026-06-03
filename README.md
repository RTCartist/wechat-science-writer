# wechat-science-writer

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/RTCartist/wechat-science-writer)](https://github.com/RTCartist/wechat-science-writer/releases/latest)

面向 [Cursor](https://cursor.com) 的 Agent Skill：将论文、PDF、网页或参考公众号文章，整理为可发布的**中文微信公众号科研导读**（标题、结构、配图解读与 Markdown 排版）。

## 特性

- 参考既有推文，复刻标题公式、开篇节奏与栏目结构
- 从论文 / PDF / URL 核对题名、DOI、期刊、作者与关键实验数据
- 按「图 X｜……」规范撰写配图解读
- 输出可直接用于微信编辑器的 Markdown 草稿

## 安装

### 从 Release 安装（推荐）

1. 打开 [Latest release](https://github.com/RTCartist/wechat-science-writer/releases/latest)
2. 下载 `wechat-science-writer-*.skill`
3. 在 Cursor 中导入该文件

### 使用 Skills CLI

```bash
npx skills add RTCartist/wechat-science-writer@wechat-science-writer -g -y
```

### 手动安装

将本仓库克隆或复制到 Cursor 用户技能目录下的 `wechat-science-writer` 文件夹：

| 平台 | 路径 |
| --- | --- |
| Windows | `%USERPROFILE%\.cursor\skills\wechat-science-writer\` |
| macOS / Linux | `~/.cursor/skills/wechat-science-writer/` |

需包含 `SKILL.md` 以及 `references/`、`templates/` 目录。

## 使用

在 Cursor 对话中描述任务即可，例如：

```
按 Nature 子刊公众号风格，根据附件 PDF 写一篇科研导读，输出 Markdown。
```

```
模仿这篇参考推文撰写论文导读，并给出 3 个标题候选。
```

## 目录说明

| 路径 | 说明 |
| --- | --- |
| `SKILL.md` | Skill 主指令 |
| `references/` | 参考推文风格分析表 |
| `templates/` | 文章结构模板 |

## 许可证

本项目采用 [MIT](LICENSE) 许可证。
