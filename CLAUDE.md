# Overview

公开的 LaTeX 中文简历模版（Apache-2.0），版式源自电子科技大学。**它是一份模版，不是任何人的真实简历**——`resume.tex` 正文全为虚构示例。

# Build & Compile

从仓库根目录编译（`customResume.cls` 与 `images/` 均相对当前目录解析）：

```bash
xelatex -output-directory=.build resume.tex
xelatex -output-directory=.build resume.tex
```

- **必须编译两次**——只编一次页眉页脚会堆到页首，这不是 bug，别改 `.cls` 去修。
- **不要硬编码 `fontset=`**——写死平台字体会换机即挂，留空由 `ctex` 自动探测。
- **编译不报错 ≠ 编译正确**：缺字体时 `nonstopmode` 仍静默产出豆腐块 PDF，必查 `grep -c 'Missing character' .build/resume.log` 为 `0`。
- 用 **XeLaTeX**（CJK 排版），依赖 `ctex` 等宏包与系统 `Times New Roman`——换机器失败先查字体 / 宏包。
- **`.build/` 已 gitignore、不入库**（含 PDF）——产物与日志可能夹带真实信息，旧「提交 `.build/*.pdf`」规则作废。

# Architecture

| 文件 | 职责 |
|---|---|
| [customResume.cls](customResume.cls) | 文档类：键值接口（`\setInfo` 填个人信息、`\setResumeStyle` 填图片路径）、主题色、页眉页脚、章节标题样式 |
| [resume.tex](resume.tex) | 正文：`\documentclass{customResume}` → 调上述两个接口 → 写各 `\section` |
| [images/](images/) | 素材：页眉页脚底图、校徽与校名、占位照片 |
| [README.md](README.md) | 面向使用者的说明与免责声明 |
| `.build/` | 编译产物，gitignore |

**数据流向**：`resume.tex` 只通过键值接口传值，排版逻辑全在 `.cls` 内；`.cls` 在 `\AtBeginDocument` 时用 tikz overlay 把页眉页脚叠到每页。

**校名显示来自图片素材而非正文文字**——页眉的「电子科技大学」是 `images/uestcZhFont.png`，与 `resume.tex` 正文（虚构的「示例大学」）互不相干。二者并存不是 bug，是刻意保留，口径见下。

# 规范

## 脱敏红线

`resume.tex` **正文**与 `images/` 中不得出现任何真实个人信息——真实姓名、电话、邮箱、微信号、真实 GitHub 账号、真实项目与竞赛名称、本人照片、证件扫描件。修改时一律用虚构示例（张三 / 13800000000 / zhangsan@example.com / 示例大学 / 示例项目）。

> 新增或替换 `resume.tex` / `images/` 中的示例内容时，按 `sanitize:sanitize-sop` 完整流程执行，不得跳过任何步骤。

## 校名口径

校徽与校名素材是**电子科技大学**的，**已确认保留，勿再清理**：

- `README.md` **如实点名**该校，并注明「个人整理、非官方、无隶属或授权关系」——不要用「示例大学」式回避
- `resume.tex` 正文仍全虚构、用「示例大学」
- 替换或移除素材时，同步更新 `README.md` 的简介与免责声明

# 本文档更新规则

更新 CLAUDE.md 文档规则：只有重要影响整个项目理解的内容才更新到 CLAUDE.md 文档中，细节部分不要更新到 CLAUDE.md 文档中耗费注意力。
