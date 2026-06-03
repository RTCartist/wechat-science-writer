# wechat-science-writer

Cursor Agent Skill：把论文、PDF、网页或参考公众号文章，改写成可发布的**中文微信公众号科研导读**（标题策略、开篇节奏、栏目结构、配图解读、Markdown 排版）。

仓库：[https://github.com/RTCartist/wechat-science-writer](https://github.com/RTCartist/wechat-science-writer)

## 功能概览

- 模仿参考推文的标题公式、开篇、栏目顺序与语气
- 从论文 / PDF / URL 提取并核对题名、DOI、期刊、作者、实验与数据
- 按「图 X｜……」规则写配图解读，输出公众号友好 Markdown
- 附带参考风格工作表与文章模板（`references/`、`templates/`）

## 安装方式

### 方式一：下载 Release 中的 `.skill`（推荐，一键导入）

1. 打开 [Releases](https://github.com/RTCartist/wechat-science-writer/releases)，下载最新版的 `wechat-science-writer.skill`。
2. 在 Cursor 中导入该 skill 文件（与从本仓库导出的包格式一致）。

本地自行打包见下方 [发布 Release](#发布-release)。

### 方式二：`npx skills` 安装

```bash
npx skills add RTCartist/wechat-science-writer@wechat-science-writer -g -y
```

全局安装到用户级 skills 目录；`-y` 跳过确认。更多说明见 [skills.sh](https://skills.sh/)。

### 方式三：Git 克隆到 Cursor skills 目录

```bash
git clone https://github.com/RTCartist/wechat-science-writer.git
```

将仓库中的 **skill 文件**（`SKILL.md` 及 `references/`、`templates/`、`scripts/`）放到 Cursor 个人 skills 目录下的 `wechat-science-writer` 文件夹中：

| 系统 | 路径 |
| --- | --- |
| Windows | `%USERPROFILE%\.cursor\skills\wechat-science-writer\` |
| macOS / Linux | `~/.cursor/skills/wechat-science-writer/` |

若使用 `~/.agents/skills/`，请放到对应路径下的同名目录。

## 使用示例

在 Cursor 对话中直接说明需求，Agent 会在匹配场景时加载本 skill，例如：

- 「按这篇 Nature 子刊公众号的风格，根据附件 PDF 写一篇科研导读」
- 「模仿这篇参考推文，写论文导读，输出可粘贴微信编辑器的 Markdown」
- 「根据 DOI / 论文链接写公众号推文，并给 3 个标题候选」

## 仓库结构

```
wechat-science-writer/
├── SKILL.md                          # 技能主文件（必需）
├── references/
│   └── reference_style_worksheet.md  # 参考推文风格分析表
├── templates/
│   └── wechat_science_article_template.md
├── scripts/
│   └── package-skill.ps1             # 打包 Release 用 .skill
├── README.md
└── LICENSE
```

## 发布 Release

在项目根目录（含 `SKILL.md` 的目录）执行：

```powershell
.\scripts\package-skill.ps1
# 带版本号文件名（可选）：
.\scripts\package-skill.ps1 -Version "1.0.0"
```

产物：`dist/wechat-science-writer.skill`（或 `wechat-science-writer-1.0.0.skill`）。将 `.skill` 文件上传到 GitHub Release 即可。

建议步骤：

1. 更新版本说明，打 tag：`git tag v1.0.0 && git push origin v1.0.0`
2. GitHub → **Releases** → **Draft a new release** → 选择 tag
3. 上传 `dist/wechat-science-writer.skill` 作为附件
4. 发布

## 许可证

[MIT](LICENSE) — Copyright (c) 2026 RTCartist
