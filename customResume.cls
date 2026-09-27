% ==========================================================
% 文件说明:
%   本 resume.cls 文件为 LaTeX 简历模板的自定义类文件。
%   主要功能：
%     - 定义个人信息与样式设置的键值接口
%     - 加载常用宏包与字体
%     - 提供页眉、页脚、背景、图标标题等简历常用命令
%     - 支持图片文件缺失时输出报错
%
% 使用说明:
%   1. 在主文档中通过 \documentclass{customResume} 使用本类文件。
%   2. 用 \setResumeStyle{...} 设置页眉、页脚、logo、背景等图片路径。例如：
%        \setResumeStyle{
%            headerPath=images/header.png,
%            headerLogoPath=images/uestcLogoWhite.png,
%            headerCharacterPath=images/uestcZhFont.png,
%            footPath=images/footer.png,
%            backgroundPath=images/uestcLogo.pdf
%        }
%   3. 用 \setInfo{...} 设置个人信息（如姓名、学校、电话、邮箱等）。例如：
%        \setInfo{
%            name=张三,
%            school=示例大学,
%            phoneNumber=13800000000,
%            email=example@mail.com,
%            githubUrl=https://github.com/yourname,
%            wechat=yourwechatid
%        }
%   4. 在文档中可直接使用以下命令：
%        \resumeHeader    % 插入页眉
%        \resumeFooter    % 插入页脚
%        \iconhead{\faUser图标命令}{个人信息}  % 图标+标题
%        \contact         % 联系方式（页脚已自动包含）
%   5. 推荐使用 XeLaTeX 编译，确保字体与 CJK 支持正常。
%   6. 若图片路径填写错误或图片缺失，将直接报错并终止编译。
% ==========================================================


% ============== preprecess class and option load ===========
\ProvidesClass{customResume} % Define the class name
\NeedsTeXFormat{LaTeX2e} % Specify the required LaTeX format
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass all options to the base class
% \ExecuteOptions{} % Default option for paper size
\ProcessOptions\relax % Process the options
\LoadClass[11pt]{article} %


% ------------------ user information variables -----------------
\RequirePackage{xkeyval}
\define@key{resume}{name}[]{% 定义键​. resume是键的“家族”（family），用于分组管理；name是键的名称；[]内可定义默认值（此处为空，表示无默认值）。
    \def\resumeName{#1} % 键的回调函数​​。当用户设置 name键时，这个函数被执行。#1代表用户传入的值，该命令将 #1定义到 \resumeName这个宏中，从而保存起来。
}
\define@key{resume}{school}[]{
    \def\resume@School{#1}
}
\define@key{resume}{phoneNumber}[]{
    \def\resume@PhoneNumber{#1}
}
\define@key{resume}{email}[]{
    \def\resume@Email{#1}
}
\define@key{resume}{githubUrl}[]{
    \def\resume@GithubUrl{#1}
}
\define@key{resume}{wechat}[]{
    \def\resume@Wechat{#1}
}
\define@key{resume}{college}[]{
    \def\resume@College{#1}
}
% 定义一个供用户使用的主命令，它接受键值对选项
% 用法：
%   \setInfo{
%     name=zhangsan,
%     school=Xi'an Jiaotong University,
%     phoneNumber=+86 123456789,
%     email=EMAIL,
%     githubUrl=https://github.com/yourname
% }
\newcommand{\setInfo}[1]{
    \setkeys{resume}{#1} %  键值对选项的解析
}


\define@key{resumeStyle}{headerPath}[]{
    \def\resumeStyle@headerPath{#1}
}
\define@key{resumeStyle}{footPath}[]{
    \def\resumeStyle@footPath{#1}
}
\define@key{resumeStyle}{headerLogoPath}[]{
    \def\resumeStyle@headerLogoPath{#1}
}
\define@key{resumeStyle}{headerCharacterPath}[]{
    \def\resumeStyle@headerCharacterPath{#1}
}
\define@key{resumeStyle}{backgroundPath}[]{
    \def\resumeStyle@backgroundPath{#1}
}

% 设置简历样式
% 用法：
%   \setResumeStyle{
%     headerPath=\images\header.png,
%     footPath=.\images\footer.png,
%     headerLogoPath=.\images\logo.png,
%     headerCharacterPath=.\images\character.png,
%     backgroundPath=.\images\background.png
%   }
\newcommand{\setResumeStyle}[1]{
    \setkeys{resumeStyle}{#1}
}

% ----------------- Load Required Packages -----------------
\RequirePackage[
    a4paper,
    left=1.2cm,
    right=1.2cm,
    top=1.5cm,
    bottom=1cm,
    nohead
]{geometry}
\RequirePackage{tikz} % for drawing
\usetikzlibrary{calc} % strengthen the tikz calculation 
\RequirePackage{tabularx} % used for tablular
\RequirePackage{fontawesome5} % for icons
\RequirePackage[colorlinks=true,linkcolor=themeColor,urlcolor=white]{hyperref} % for links - configured to suppress bookmark warnings
\urlstyle{tt} % set the url to typewriter style
\RequirePackage{calc} % for \widthof command
\RequirePackage{multicol} % for multicolumn
\RequirePackage{etoolbox} % for \ifdef command


% ------------------ font settings -----------------
\RequirePackage{fontspec}

% Check if Chinese mode is enabled before executing Chinese-specific commands
% Load Chinese-specific packages and settings
\RequirePackage[UTF8]{ctex} % Enable Chinese support (auto-detect system fonts)
% \RequirePackage{xeCJK} % Additional CJK font support
% \CJKsetecglue{} % 取消中文字符与数字之间的间隔
\setlength{\parindent}{0pt} % 取消全局段落缩进
% \renewcommand{\CJKglue}{\hskip 0.05em}  % 中文字符间距
\pagenumbering{gobble} % 取消页码显示

% % 设置中文字体为开源的近似宋体 Noto Serif CJK SC 和 Noto Sans CJK SC
% \setCJKmainfont{Noto Serif CJK SC}[
%     BoldFont = Noto Serif CJK SC Bold,
%     ItalicFont = Noto Serif CJK SC,
%     BoldItalicFont = Noto Serif CJK SC Bold
% ]
% \setCJKsansfont{Noto Sans CJK SC}[
%     BoldFont = Noto Sans CJK SC Bold
% ]
% \setCJKmonofont{Noto Sans Mono CJK SC}

% 设置英文字体
% \setmainfont{Roboto}[ % Google Fonts 免费字体
%     BoldFont       = Roboto Bold,         % 粗体设置为 Roboto Bold
%     ItalicFont     = Roboto Italic,       % 斜体设置为 Roboto Italic
%     BoldItalicFont = Roboto Bold Italic   % 粗斜体设置为 Roboto Bold Italic
% ]
\setmainfont{Times New Roman}


% -------------- theme color --------------
\RequirePackage{xcolor} % for defining colors and set text color
\definecolor{NPU_Blue}{RGB}{0, 80, 158} % 西工大蓝
\definecolor{primary_color}{RGB}{63, 97, 21}    % 松针绿
\definecolor{secondary_color}{RGB}{255, 204, 0} % 金陵黄
\definecolor{WHU_Blue}{RGB}{0, 37, 84} % 武大蓝
\colorlet{themeColor}{NPU_Blue}


% -------------- beautify C++ --------------
\RequirePackage{xspace}
\RequirePackage{relsize}
\DeclareRobustCommand{\Cpp}{{C\nolinebreak[4]\hspace{-.05em}\raisebox{.28ex}{\relsize{-1}++}}\xspace}  % 这是个更好看的C++写法，你直接写C++的话，+号会很大，可以使用\Cpp来代替
\renewcommand{\arraystretch}{1.2}  % 这里把表格的行间距调成1.2倍了
\linespread{1.2} % 这里把正文的行间距调成1.2倍了


% -------------- enumerater --------------
\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=2\ccwd, topsep=0pt, partopsep=0pt, itemsep=0pt, parsep=0pt} % 条目间距与正常行间距一致
\setlist[enumerate]{leftmargin=2\ccwd, topsep=0em, partopsep=0pt, itemsep=0pt, parsep=0pt} % 增加了enumerate顶部间距

% ------------ section formatting ------------
\RequirePackage{titlesec} % for section formatting

% 将原标题前面的数字取消了
\titleformat{\section}
% {\large\bfseries\raggedright} % 字体改为LARGE，bold，左对齐
{\bfseries\raggedright} % 字体改为LARGE，bold，左对齐
{}{0em}   % first {} ： label (\the section)  second {} : the seperate space between label and title character   取消section编号
{}   % 标题前代码
[{\color{themeColor}\titlerule}]            % 标题后代码
\titlespacing*{\section}{0cm}{*1}{*1}    % 标题左边留白，上方正常行距，下方正常行距

% 将原二级标题前面的数字取消了
\titleformat{\subsection}
% {\large\bfseries\raggedright} % 字体改为large，bold，左对齐
{\bfseries\raggedright} % 字体改为large，bold，左对齐
{}{0em} % 可用于添加全局二级标题前缀
{}      % 可用于添加代码
[]
\titlespacing*{\subsection}{0cm}{*1.3}{*0.8}% 二级标题左边留白，上方1倍，下方1倍

% \intextsep 控制的是出现在正文中间的 浮动体(如 table ) 与其上下文字之间的距离
\setlength{\intextsep}{0pt} 
% \textfloatsep 控制的是位于页面顶部或底部的浮动体 (如 table) 与正文之间的距离
\setlength{\textfloatsep}{0pt}

\setlength{\multicolsep}{0pt} % multicols 和上下文之间的额外距离

% ----------------------- define hangfrom environment ----------------------- 
% 用法：
%  \begin{hangfrom}{标题}
%      内容
%  \end{hangfrom}
\newenvironment{hangfrom}[1]{
    \begingroup
    \newlength{\labelwidthname}
    \settowidth{\labelwidthname}{\textbf{#1}：} % 自动测量标题+冒号+间距的宽度
    \hangafter=1
    \hangindent=\labelwidthname
    \textbf{#1}：
}{
    \par
    \endgroup
}

% -------------------- resume header --------------------
% 用法：
%   \resumeHeader
\NewDocumentCommand{\resumeHeader}{}{
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north, inner sep=0pt](header) at (current page.north){
            \IfFileExists{\resumeStyle@headerPath}{
                \includegraphics[width=\paperwidth]{\resumeStyle@headerPath}
            }{
                \PackageError{resume}{File `\resumeStyle@headerPath' not found}{The header image file is missing.}
            }
        };
        \node[anchor=west](school_logo) at (header.west){
            \hspace{0.5cm}
            \IfFileExists{\resumeStyle@headerLogoPath}{
                \includegraphics[width=0.07\textwidth]{\resumeStyle@headerLogoPath}
            }{
                \PackageError{resume}{File `\resumeStyle@headerCharacterPath' not found}{The header character image file is missing.}
            }
            \raisebox{1.5ex}{
                \IfFileExists{\resumeStyle@headerLogoPath}{
                    \includegraphics[width=0.25\textwidth]{\resumeStyle@headerCharacterPath}
                }{
                    \PackageError{resume}{File `\resumeStyle@headerChatacterPath' not found}{The header logo image file is missing.}
                }
            }
        };
        \ifdef{\resume@School}{
            \node[anchor=east](school_name) at(header.east){
                \textcolor{white}{\textbf{ \resume@School }}
                \hspace{0.5cm}
            };
        }{}
    \end{tikzpicture}
}

% -------------------- contact command  --------------------
% 用法: 
%   \contact
\NewDocumentCommand{\contact}{}{
    \scriptsize
    \textcolor{white}{
        \faEnvelope \quad \href{mailto:\resume@Email}{\resume@Email}
        \hspace{4em}
        \ifdef{\resume@Wechat}{
            \faWeixin \quad \resume@Wechat
            \hspace{4em}
        }{}
        \ifdef{\resume@PhoneNumber}{
            \faPhone \quad \resume@PhoneNumber
            \hspace{4em}
        }{}
        \faGithub \quad \href{\resume@GithubUrl}{\resume@GithubUrl}
    }
}


% -------------------- resume footer --------------------
% 用法：
%   \resumeFooter
\NewDocumentCommand{\resumeFooter}{}{
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=south, inner sep=0pt](footer) at (current page.south){
            \IfFileExists{\resumeStyle@footPath}{
                \includegraphics[width=\paperwidth]{\resumeStyle@footPath}
            }{
                \PackageError{resume}{File `\resumeStyle@footPath' not found}{The footer image file is missing.}
            }
        };
        \node[anchor=center] at(footer.center){
            % \small % font size
            % \footnotesize 
            \scriptsize % font size
            \textcolor{white}{
                \ifdef{\resume@Email}{
                    \faEnvelope \quad \href{mailto:\resume@Email}{\resume@Email}
                    \hspace{4em}
                }{}
                \ifdef{\resume@Wechat}{
                    \faWeixin \quad \resume@Wechat
                    \hspace{4em}
                }{}
                \ifdef{\resume@PhoneNumber}{
                    \faPhone \quad \resume@PhoneNumber
                    \hspace{4em}
                }{}
                \ifdef{\resume@GithubUrl}{
                    \faGithub \quad \href{\resume@GithubUrl}{\resume@GithubUrl}
                }{}
                % \begin{tabularx}{\linewidth}{XXXX}
                % \faEnvelope \quad \href{mailto:\resume@Email}{\resume@Email}
                % \faWeixin \quad \resume@Wechat
                % \faPhone \quad \resume@PhoneNumber
                % \faGithub \quad \href{\resume@GithubUrl}{\resume@GithubUrl}
                % \end{tabularx}
            }
        };
    \end{tikzpicture}
}

% % ------------------- logo background -------------------
% \RequirePackage[pages=all]{background}
% \backgroundsetup{
%     scale=0.7,
%     angle=0,
%     position=current page.center,
%     vshift=0cm,
%     hshift=0cm,
%     contents={
%         \IfFileExists{\resumeStyle@backgroundPath}{
%             \begin{tikzpicture}
%                 \node[opacity=0.1] {\includegraphics[width=\paperwidth, keepaspectratio]{\resumeStyle@backgroundPath}};
%             \end{tikzpicture}
%         }{
%             \PackageError{resume}{File `\resumeStyle@backgroundPath' not found}{The background image file is missing.}
%         }
%     }
% }


% ---------------- icon header -----------------------
% 用法：
%   \iconhead{标题icon}{标题内容}
\newcommand{\iconhead}[2]{
    \texorpdfstring{\makebox[\widthof{#1}][c]{\color{themeColor}{#1}}\quad#2}{#2}
}

% % --------------- append newpage cmd ----------------
% \RequirePackage{xpatch}
% \xapptocmd{\newpage}{
%     \resumeHeader
%     \resumeFooter
% }{}{} % 定义这个会自动添加空白页，不知道为什么

% -------------- add begindocument hook ----------------
\AtBeginDocument{
    \resumeHeader
    \resumeFooter
}


