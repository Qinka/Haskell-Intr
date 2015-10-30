
> module Example
>     (
>     ) where

\documentclass[UTF8]{ctexart}
\usepackage{xeCJK}
\usepackage{listings}
\lstset{breaklines}
\author{Qinka}

\title{Haskell Example}

\begin{document}

\maketitle
这篇文章主要是用于 SSSTA 于 11月1日上午活动中 Haskell 特性演示的文稿，其中该文档是 Literate Haskell 版本。
可直接使用 GHCi 等编译与使用，但对于 \LaTeX 文档编译，则需要 lhc 编译器的帮助，产生可编译的 \LaTeX 文档。
\section{Haskell 基本特性的演示}
\subsection{静态类型}
Haskell 的静态类型，带来的是许多好处。
\begin{lstlisting}[language=Haskell]
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
\end{lstlisting}

同时，Haskell 对泛型的编程的良好的支持，其中对$1024$的实际类型是不明确的，因为其类型可以为整数或浮点，等类型。
而其中 \verb"Num a => a" 意思是 其数据的类型的是实现了 类型类 Num 的 一个类型。而类型类的概念就像汽车与飞机的概念一样，
造出来的交通工具是飞机还是汽车，就看这个交通工具满足的特性有那些。



\end{document}
