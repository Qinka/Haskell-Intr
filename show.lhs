\documentclass[UTF8]{ctexart}
\usepackage{xeCJK}
\usepackage{listings,color}
\lstnewenvironment{code}{\lstset{language=Haskell,breaklines,backgroundcolor=\color[rgb]{0.84,1.00,0.92},basicstyle=\sffamily,keywordstyle=\bfseries,commentstyle=\rmfamily\itshape,escapechar=~,flexiblecolumns,numbers=left,numberstyle=\tiny,frame=trBL,label=sourceCtr}}{}
\lstnewenvironment{spec}{\lstset{language=Haskell,breaklines,backgroundcolor=\color[rgb]{1.00,0.50,1.00},basicstyle=\sffamily,keywordstyle=\bfseries,commentstyle=\rmfamily\itshape,escapechar=~,flexiblecolumns,numbers=left,numberstyle=\tiny,frame=trBL,label=sourceCtr}}{}
\long\def\ignore#1{}
\author{Qinka}

\title{Haskell Example}

\begin{document}

\ignore{

> module Example
>     (
>     isEqOne,
>     isEqTwo
>     ) where

}

\maketitle
这篇文章主要是用于 SSSTA 于 11月1日上午活动中 Haskell 特性演示的文稿，其中该文档是 Literate Haskell 版本。
可直接使用 GHCi 等编译与使用，但对于 \LaTeX 文档编译，则需要 lhc 编译器的帮助，产生可编译的 \LaTeX 文档。
以下是引用的模块：
\begin{code}
import Prelude -- base
\end{code}
\section{Haskell 基本特性的演示}
\subsection{静态类型}
Haskell 的静态类型，带来的是许多好处。

\begin{spec}
Prelude> -- 这是一个演示输出与输入的实例
Prelude> :t 1024
1024 :: Num a => a
Prelude> :t "abc"
"abc" :: [Char]
Prelude> "abc" + 1

<interactive>:1:7:
    No instance for (Num [Char]) arising from a use of ‘+’
    In the expression: "abc" + 1
    In an equation for ‘it’: it = "abc" + 1
\end{spec}

同时，Haskell 对泛型的编程的良好的支持，其中对$1024$的实际类型是不明确的，因为其类型可以为整数或浮点，等类型。
而其中 \verb"Num a => a" 意思是 其数据的类型的是实现了 类型类 Num 的 一个类型。而类型类的概念就像汽车与飞机的概念一样，
造出来的交通工具是飞机还是汽车，就看这个交通工具满足的特性有哪些。

\subsection{$\lambda$表达式}
$\lambda$表达式是从$\lambda$演算中“提取的”。其与许多语言中的匿名函数相似，甚至可以说几乎是一样的。
基本的格式是：
$$\lambda_x \rightarrow \lambda_y \rightarrow \dots expression(s)$$

例如，判断一个数是否是2的谓词\footnote{谓词这一概念，来自于《离散数学（第二版）》，由西安电子科技大学出版社出版。}的代码，如下
\begin{code}
isEqOne :: (Num a,Eq a) => a -> Bool
isEqOne = \x -> x == 1
\end{code}
其中，第一行的 Num 与 Eq 为两个类型类，对于实现了这个类型类的类型，我们就说它们是数而且可确定是否相等。而返回值是布尔类型，其中，在 Haskell
中类型与类型类等得名称是均是由大写字母开头，而函数与所谓的“变量”，是由小写开头 \footnote{其中中文汉子与标点等效于小写字母。}
\subsection{“条件”表达式}
Haskell 中 有几种表达“条件”的表达式。
\subsubsection{if-then-else}
Haskell 的条件语句，不像指令式语言的那样，if 与 else 必须都有。如下是错误代码示例：
\begin{spec}
if 1 == 2 then putStrLn "Unbelievable"
\end{spec}
下面是判断一个数是否是2的函数，并返回一个字符串。
\begin{code}
isEqTwo :: Int -> String
isEqTwo x = if x == 2 then "Two!" else "It is not two."
\end{code}


\end{document}
