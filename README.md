<div align="center">

# 📄 LaTeX 简历模版

[![GitHub](https://img.shields.io/badge/GitHub-Repository-black?logo=github)](https://github.com/airprofly/resume_uestc) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![LaTeX](https://img.shields.io/badge/LaTeX-2e-blue.svg)](https://www.latex-project.org/) [![XeLaTeX](https://img.shields.io/badge/XeLaTeX-Required-orange.svg)](https://tug.org/xetex/)

</div>

---

## 📖 简介

一份**基于电子科技大学简历版式的中文简历模版**（个人整理，**非学校官方发布**，与该校不存在隶属或授权关系）。

正文示例为虚构内容（张三 / 示例大学 / 示例项目），与真实个人无关；页眉、页脚与校徽素材的版权归原学校所有，**使用者应替换为自有素材**，详见文末免责声明。

> 📄 **效果预览**：[`.build/resume.pdf`](.build/resume.pdf)，无需编译即可查看。

## 📌 特性

- ✅ **上手成本低**：不用碰排版——页边距、字号、章节图标均已排好，只改 `\setInfo` 里的中文内容；编译两次即得 PDF，中文自动探测字体
- ✅ **美观**：全幅图片页眉页脚、主题色、图标章节标题，开箱即排版精修效果
- ✅ **章节按需增减**：自我评价、个人优势等已预置，取消注释即可启用

## 📁 目录结构

```text
resume_uestc/
├── customResume.cls      # 自定义文档类（核心）
├── resume.tex            # 简历正文
├── images/               # 页眉/页脚/logo/照片等图片资源
├── .build/resume.pdf     # 编译成品（无需编译即可查看效果）
├── LICENSE               # Apache License 2.0
└── README.md
```

## 🔧 环境要求

- **TeX 发行版**：[TeX Live](https://www.tug.org/texlive/)（推荐）或 MiKTeX
- **编译引擎**：**XeLaTeX**（必须，CJK 排版依赖）
- **字体**：西文 `Times New Roman`；中文由 `ctex` 自动探测系统字体

> 依赖宏包已在 `customResume.cls` 中声明，完整的 TeX Live（mactex / texlive-full）自带，无需单独安装。

```bash
# macOS
brew install --cask mactex

# Ubuntu / Debian
sudo apt-get install texlive-xetex texlive-latex-extra texlive-fonts-extra
```

## 🚀 快速开始

```bash
git clone https://github.com/airprofly/resume_uestc.git
cd resume_uestc

# 必须编译两次
xelatex -output-directory=.build resume.tex
xelatex -output-directory=.build resume.tex

open .build/resume.pdf
```

> ⚠️ **只编一次会让页眉和页脚都堆到页首**，补编一次即可。

## ✏️ 自定义

> 📝 本节仅列常用改动，**完整使用说明**见 [Notion 文档](https://app.notion.com/p/airprofly/3cd099a124ee81308a23f2681e7ea547?v=3ce099a124ee800c8fee000c1d6b1470)。

### 1. 个人信息

页眉右侧的学院名、页脚的联系方式均由 `\setInfo` 驱动，只需改这一处：

```latex
\setInfo{
    name=你的姓名,
    school=你的学院,
    phoneNumber=13800000000,
    email=you@example.com,
    githubUrl=https://github.com/yourname,
    wechat=your-wechat
}
```

### 2. 图片样式

替换 `images/` 下的图片，或改路径：

```latex
\setResumeStyle{
    headerPath=images/header.png,           % 页眉底图
    headerLogoPath=images/uestcLogoWhite.png, % 页眉左logo
    headerCharacterPath=images/uestcZhFont.png, % 页眉校名字
    footPath=images/footer.png,             % 页脚底图
    backgroundPath=images/uestcLogo.pdf     % 背景水印（默认关闭）
}
```

- **个人照片**：替换 `images/personalPhoto.jpg`（建议竖版）
- **主题色**：改 `customResume.cls` 中的 `\colorlet{themeColor}{...}`，文件里已预置几套备选色

### 3. 正文内容

按 `resume.tex` 中各 `\section` 的示例格式替换；可用图标见该文件头部注释。

## ❓ FAQ

**Q1：中文变成方块，或换机器就编译失败？**

**A：** 多是字体或宏包缺失，注意两点：

- **换平台无需改代码**——本模版不绑定中文字体
- **编译不报错也会产出豆腐块 PDF**——务必查日志确认：

      grep -c 'Missing character' .build/resume.log   # 应为 0

## ⚠️ 免责声明

- **非官方**：本模版由个人整理，**非电子科技大学官方发布**，与该校不存在隶属、授权或合作关系，**不得用于可能使人误认为与该校有关的用途**。
- **校徽与校名图片**：`images/uestcLogo.pdf`、`images/uestcLogoWhite.png`、`images/uestcZhFont.png`
  及页眉页脚底图中的学校标识，**版权归电子科技大学所有**，此处仅作为排版示例保留，使用者应自行替换为自有素材。
- **上游来源**：本模版的 `customResume.cls` 与图片素材在整理时已无法追溯原始出处，
  故未标注上游署名。若你是相关权利人，请联系以便补充署名或移除。
- **示例内容**：`resume.tex` 中的姓名、联系方式、学校、项目、奖项等**均为虚构**，与真实个人无关。
