---
name: wechat-science-writer
description: Create or revise Chinese WeChat Official Account science/research articles from papers, PDFs, URLs, and reference posts. Use when the user asks to imitate a WeChat article style, write a公众号推文, 科研解读, 论文导读, 图文解读, or package a repeatable WeChat writing workflow covering tone, structure, figures, and Markdown layout.
---

# WeChat Science Writer

Use this skill to produce **Chinese WeChat Official Account research explainer articles** from academic papers, PDFs, webpages, or user-provided reference posts. The goal is not only to summarize a paper, but to convert it into a publishable公众号推文 with a consistent **title strategy, opening rhythm,栏目结构, writing voice, figure interpretation, and final layout**.

## Core Workflow

Follow these steps in order unless the user explicitly requests a shorter edit.

1. **Clarify inputs and constraints.** Identify the source paper, uploaded files, reference WeChat post, desired account persona, target readers, length, and whether the user wants direct copy-ready Markdown.
2. **Analyze the reference article.** If a WeChat link requires verification, open the page and ask the user to take over. If the user provides screenshots or copied text, analyze those instead. Save observations about title formula, opening,栏目顺序, paragraph length, figure captions, data emphasis, and ending style.
3. **Read and verify the research source.** Extract the paper title, DOI, journal, date, authors, institutions, research question, method, experiments, quantitative results, limitations, and significance. Use the paper PDF and, when available, the publisher page to cross-check bibliographic details.
4. **Analyze figures before writing.** Inspect the main figures, captions, and visual logic. For each main figure, record what it shows, why it matters, what subfigures support the claim, and which article section should contain it.
5. **Draft in the reference style.** Recreate the reference article's rhetorical structure without copying proprietary wording. Match the level of technicality, pacing, and section order while using the new paper's content.
6. **Add figure interpretation inline.** Insert "图 X｜……" paragraphs near the relevant discussion rather than isolating all image notes at the end.
7. **Run the quality checklist.** Check factual accuracy, citation coverage, tone consistency, figure clarity, WeChat readability, and Markdown cleanliness before delivery.

## Reference Style Extraction Rubric

When imitating a WeChat reference post, extract these features and use them as the article blueprint.

| Dimension | What to Extract | How to Reuse |
| --- | --- | --- |
| Title | Journal tag, team/institution, material/device/model, mechanism, application result | Build a title like "[Nature子刊]团队用X实现Y" or "[顶刊]让X像Y一样Z" |
| Opening | Account greeting, publication date, journal, paper title, DOI, keywords, one-paragraph hook | Start directly and concretely; avoid long abstract-style openings |
| Section Order | Background, one-sentence summary, core technology, experiments, discussion, limitations | Preserve the same reading rhythm unless the paper requires a different logic |
| Tone | Professional but accessible, short technical explanations, strong verbs, restrained praise | Use vivid phrases only when anchored in data or mechanism |
| Data Style | Accuracy, speedup, energy, robustness, sample size, dataset | Bold key numbers and explain the comparison baseline |
| Figure Style | "图 X｜……" caption-like explanation, subfigure-by-subfigure reading | Put figure interpretation immediately after the related section |
| Ending | Deep discussion, limitations, future outlook, concise takeaway | Avoid promotional exaggeration; end with a conceptually strong sentence |

## Default Article Structure

Use this flexible structure for Nature/Science/Cell-style research explainer posts. Adapt section names to the reference article if needed.

```markdown
# [期刊标签]团队/机构用核心技术实现关键结果

这里是[公众号名称或默认科研导读口吻]，今天带大家解读一篇[发表日期/接收日期]发表在 **[期刊]** 上的论文。论文题目：**[English Title]**。[1]

DOI：[DOI]

关键词：[关键词1] / [关键词2] / [关键词3] / [关键词4]

[一段导读：本文报道了什么系统/方法，解决什么痛点，关键性能数据是什么，为什么重要。]

![论文首页截图｜建议插入论文首页或TOC图](论文首页截图占位)

# 背景介绍

[解释领域痛点、现有方法局限、为什么需要这项工作。]

![图1｜建议插入论文Figure 1](图1占位)

图 1｜[图1标题式解读。按a、b、c等子图解释视觉信息，并总结这张图在全文中的功能。]

# 一句话概括

[用一段话压缩核心贡献：方法 + 机制 + 关键数据 + 意义。]

# 核心技术

[拆解系统、材料、算法、模型或电路机制。]

![图2｜建议插入论文Figure 2](图2占位)

图 2｜[解释器件/模型/架构链条，说明每个子图如何支撑核心技术。]

# 性能实测与关键结果

[按任务或实验展开，不只罗列数据，要解释每个结果证明了什么。]

![图3｜建议插入论文Figure 3](图3占位)

图 3｜[解释实验过程、曲线/热图/轨迹、比较基线和关键结论。]

# 深度讨论

[提炼范式意义：为什么这项工作不只是工程改进，而是方法论变化。]

# 局限性与展望

[客观说明规模、数据集、器件、电路、泛化或工程化挑战。]

# 总结

[用2—3段收束，回到标题中的核心概念。]

# 参考来源

[1]: [URL] "[Title]"
```

## Writing Voice Rules

Use a **公众号科研导读** voice: accurate, readable, and moderately vivid. The article should feel like an expert is guiding readers through a paper, not like a translated abstract.

Use expressions such as "本文报道了一种……", "这项研究的核心突破在于……", "换句话说……", "这张图真正想说明的是……", and "系统级评测显示……". Use them to clarify mechanisms, not to inflate claims.

Avoid empty hype such as "颠覆性革命", "彻底解决", "完美实现", or "史无前例" unless the paper itself makes and supports such claims. Prefer "提供了一条新路径", "展示了可行性", "为……提供了硬件基础", and "仍处于概念验证阶段".

For technical concepts, use a two-layer explanation. First give the intuitive meaning in plain Chinese, then provide the formal term in parentheses. Example: "模型并不是一次性生成图像，而是从随机噪声出发，沿着学到的概率方向逐步去噪，这就是扩散模型（diffusion model）的基本思想。"

## Title Rules

Generate 3 candidate titles when the user has not fixed one. Prefer titles with this structure:

| Title Pattern | Example |
| --- | --- |
| `[期刊标签] + 团队 + 用X实现Y` | `[Nature子刊]港大等团队用阻变存储器"连续求解"扩散模型` |
| `[期刊标签] + 技术隐喻 + 应用结果` | `[Nature子刊]让芯片像大脑一样"想象"：阻变存储器实现低功耗AIGC生成` |
| `核心痛点 + 新方案` | `扩散模型太耗能？这项工作让生成过程在模拟芯片上连续演化` |

A good title should include at least two of the following: **journal level, team/institution, key material/device/model, core mechanism, application scenario, quantitative result**.

## Figure Interpretation Rules

For each main figure, write a caption-like paragraph beginning with **"图 X｜"**. Do not merely translate the original caption. Explain how the figure helps the reader understand the paper.

Each figure interpretation should cover four elements:

1. **What the figure shows.** Describe the visual layout, subfigures, axes, modules, or flow.
2. **Why it matters.** State what claim this figure supports.
3. **How to read it.** Walk through key subfigures in order, especially a–d or a–h panels.
4. **Takeaway.** End with one sentence explaining what readers should remember.

Use this format:

```markdown
图 X｜[一句话总括这张图的作用]。a，[子图a说明]。b，[子图b说明]。c–d，[合并解释相关子图]。这张图的核心信息是：[用一句话概括它在全文论证中的作用]。
```

When images cannot be embedded directly, insert Markdown placeholders such as:

```markdown
![图X｜建议插入论文Figure X](图X占位)
```

## Layout Rules for WeChat-Ready Markdown

Write in Markdown that can be pasted into a WeChat editor after light formatting. Use short paragraphs, clear section headers, and bold for key numbers. Avoid overusing tables; use them only for comparisons that are easier to read in tabular form.

| Element | Rule |
| --- | --- |
| Paragraphs | Usually 2–5 sentences; one idea per paragraph |
| Headings | Use `#` for main sections in draft Markdown; editors can restyle later |
| Key numbers | Bold speedups, energy reductions, accuracy, sample size, and dataset names |
| Images | Add placeholders with clear insertion instructions |
| Citations | Use numeric Markdown references for factual claims and sources |
| English terms | Keep original term in parentheses at first mention |
| Tables | Use only when comparing methods, metrics, or title options |

## Quality Checklist

Before delivery, verify the article against this checklist.

| Check | Pass Criteria |
| --- | --- |
| Source accuracy | Title, DOI, journal, publication date, authors/institutions, and data match the source |
| Reference style | Title, opening,栏目顺序, figure style, and ending match the reference post's pattern |
| WeChat readability | The article reads smoothly for interdisciplinary technical readers |
| Technical precision | Terms such as model, hardware, dataset, metric, and baseline are not confused |
| Figure usefulness | Each major figure interpretation explains visual logic and scientific claim |
| Balanced tone | Contributions are clear, limitations are included, and hype is avoided |
| Publish readiness | Markdown is clean, image placeholders are explicit, references are included |

## Delivery

Deliver the final article as a `.md` file. In the user-facing message, briefly state what was produced and mention whether the style was based on an accessible reference post, screenshots, or inferred style notes. If the WeChat reference page was blocked and the user did not provide access, clearly say that the style match is approximate.
