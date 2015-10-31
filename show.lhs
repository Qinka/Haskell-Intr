\documentclass[UTF8]{ctexart}
%\usepackage{xeCJK}
\usepackage[colorlinks,linkcolor=blue,anchorcolor=blue,citecolor=red,bookmarksnumbered]{hyperref}
\usepackage{listings,color,attachfile2}
\lstnewenvironment{code}{\lstset{language=Haskell,breaklines,backgroundcolor=\color[rgb]{0.84,1.00,0.92},basicstyle=\sffamily,keywordstyle=\bfseries,commentstyle=\rmfamily\itshape,escapechar=~,flexiblecolumns,numbers=left,numberstyle=\tiny,frame=trBL,label=sourceCtr}}{}
\lstnewenvironment{spec}{\lstset{language=Haskell,breaklines,backgroundcolor=\color[rgb]{1.00,0.50,1.00},basicstyle=\sffamily,keywordstyle={},commentstyle=\rmfamily\itshape,escapechar=~,flexiblecolumns,numbers=left,numberstyle=\tiny,frame=trBL,label=sourceCtr}}{}
\long\def\ignore#1{}
\author{Qinka}

\title{Haskell Example}

\begin{document}

\ignore{

> module Example
>     (
>     isEqOne,
>     isEqTwo,
>     stringToBool,
>     caseEx1,
>     caseEx2,
>     guardEx1,
>     sumEx,
>     addOneEx,
>     ) where

}

\maketitle
这篇文章主要是用于 SSSTA 于 11月1日上午活动中 Haskell 特性演示的文稿，其中该文档是 Literate Haskell 版本。
这个文件可以直接被GHCi读取，同时可以使用 \LaTeX 的引擎处理，笔者这边使用的是XeLaTeX。
其中，粉色背景的代码是不会被GHCi等读取，而绿色背景的代码是主要部分。
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

例如，判断一个数是否是1的谓词\footnote{谓词这一概念，来自于《离散数学（第二版）》，由西安电子科技大学出版社出版。}的代码，如下
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

\subsubsection{casee-of}
Haskell 中有类似于 C 等语言中的 switch 语句---- “case-of” 语句，和 C 语言种不同的是， switch 只接受整数的条件参数。而 Haskell
则接受各种数据类型。例子如下：
\begin{code}
stringToBool :: String -> Bool
stringToBool x = case x of
  "True" -> True
  _ -> False
\end{code}
其中 $->$ 表示如果当前的表达式匹配成功之后执行的运算，事实上本质是函数。而 \_ 这个是指带任何情况都适配同事忽略它是啥。而如果只是给出一个“变量”，则其也会
成功适配，而同事吧数据给了变量。

更多的例子：
\begin{code}
caseEx1 :: Num a => [a] -> a
caseEx1 x = case x of
  (y:ys) -> y + caseEx1 ys
  _ -> 0
\end{code}
\begin{code}
caseEx2 :: (Show a) =>  Maybe a -> String
caseEx2 x = case x of
  Just p -> show p
  Nothing -> "nothing"
\end{code}
在第二个例子中，\verb"Mabye" \verb"Just" \verb"Nothing" 是一起的，是一种“奇特”的东西，对于学过 C 等语言的人来说。有点像模板。之后
我们会再次提起这个神奇而强大的东西。同时，case-of 这样的代码在可以换成另一种方式：
\begin{spec}
caseEx2 (Just x) = show x
caseEx2 Nothing = "Nothing"
\end{spec}
至于具体细节会在之后提到。
\subsubsection{“沈文元”}
你们可能会奇怪，沈文元是谁。但是不得不说，其实是守门员
\footnote{这其实是一个笑话，有个人找一个叫沈文元的人，结果应答的那个人一直是听成的是守门员。}
。不，事实上是守卫表达式。先看一个例子：
\begin{code}
guardEx1 ::(Eq a, Num a)  => a -> Bool
guardEx1 x
  | x == 1 = True
  | otherwise = False
\end{code}
其中，otherwise 是 一个返回值为 True 的函数，而门卫 之后所更随的代码则是 一个条件表达式，如果为真则执行后面的内容。
\subsection{递归与高阶函数}
Haskell 是不纯在循环体的 \footnote{不存在像 C 等语言那样的循环体，当然也不存在变量这样的东西。}，而 Haskell 确实是图灵完备的，
这就意味着 Haskell 可以做到其他语言可以做到的事。下面是个例子：
\begin{code}
sumEx :: (Eq a, Num a) => [a] -> a
sumEx [] = 0
sumEx (x:xs) = x + sumEx xs
\end{code}
这个递归函数，只定义了两件事：什么时候停止与在不停止的时候要干什么。

对于高阶函数，就是指一个函数可以像数据一样，传入一个函数与从函数中返回。例子如下：
\begin{code}
addOneEx :: Num a => [a] -> [a]
addOneEx = map (+1)
\end{code}
其中，map 是一个函数，将会将传入的作为参数的函数\footnote{本例中是 (+1) 其类型绑定是 Num a => a -> a。}，作用于“第二个参数”
\footnote{这里加引号的原因是在 Haskell 中，函数式 curry 化的。}的每个元素。而这个函数的作用将一个数的列表中的每个元素加一。
而这个表达式则是将一个返回的函数赋值给了 addOneEx。
\subsection{curry 化函数}
curry 化函数的结果，函数的参数不一定要一次性全部提供，如果提供不完全，则会产生一个新的函数。以下是一个运行结果。
以下是对几个不同函数的绑定类型的查看。
\begin{spec}
Prelude> :t map
map :: (a -> b) -> [a] -> [b]
Prelude> :t (+)
(+) :: Num a => a -> a -> a
Prelude> :t (+1)
(+1) :: Num a => a -> a
Prelude> :t map (+1)
map (+1) :: Num b => [b] -> [b]
Prelude> :t map (+1) [1..]
map (+1) [1..] :: (Enum b, Num b) => [b]
\end{spec}
\subsection{列表内包}
列表内包是一种构造列表的方式。假设$P_1$ 至 $P_n$是 n个谓词，$A_1$至$A_m$ 是 m 个集合。则一个新的集合
$$ \{ (e_1,e_2\cdot e_m) | e_1 \in A_1 \cdot e_m \in A_m , P_1(e_1,e_2\cdot e_m),P_2(e_1,e_2\cdot e_m)\cdot P_n(e_1,e_2\cdot e_m)\}$$
而 Haskell 有类似的语法，如构造一个所有元素不能被13整除的偶数列表。
\begin{spec}
Prelude> [x |x<-[2,4..] , mod x 13 /= 0]
[2,4,6,8,10,12,14,16,18,20,22,24,28,30,32,34,36,38,40,42,44,46,48,50,54,56,58,60,62,64,66,68,70,72,74,76,80,82,84,86,88,90,92,94,96,98,100,102,106,108,110,112,114,116,118,120,122,124,Interrupted.
\end{spec}
由于这个列表构造出来的是无限长度的列表，则需要手动终止。其中的某些细节将在之后展示。
\subsection{其他基本的特性}
\subsubsection{Maybe}
Maybe 可以说代表着 Haskell 中 很多东西的特性。其定义如下：
\begin{spec}
	data Maybe a = Just a | Nothing
\end{spec}	
其含义是一个类型如果是 Maybe a，则其要么为 Just x ，其中x 为类型为a的数据，要么为 Nothing。而 a 的类型并不做限制，类似于 C++ 等中的模板。

其中我们称 Just 与 Nothing 为 类型构造器，与函数相似。

Haskell 中还存在其他的特性其中值得一体的是 QuickCheck 与类型系统。这些东西就留给给位自己查阅在线资料了。
\section{高级特性--求值策略}
在此我们只简单介绍并不深入探讨。
\subsection{惰性求值}
Haskell 默认的是惰性求值。也就是说一个参数的值，只是会在需要的时候进行求解。
\footnote{其中使用到的 :sprint 命令是在 GHCi 中查看一个“变量”的“内存”是什么样的，fst 是返回二元组的第一个元素的函数。}
\begin{spec}
Prelude> let x = 1 :: Int
Prelude> let y = (x+x,x+x+x)
Prelude> :sprint x
x = 1
Prelude> :sprint y
y = (_,_)
Prelude> fst y
2
Prelude> :sprint y
y = (2,_)
\end{spec}
其中 y 是一个 二元组，其后一个元素在没有被用到的情况下是不会被求值的。
再来一个例子：
\begin{spec}
Prelude> let x = 1+1::Int
Prelude> :sprint x
x = _
Prelude> x
2
Prelude> :sprint x
x = 2
\end{spec}
\subsection{弱首范式[Weak Head Normal Form]}
弱首范式与首范式\footnote{Head Normal Form}，范式\footnote{Normal Form。这些翻译参照了 《Haskell 并发与并行编程》一书，该书中文版由 O'Reilly 出版社授权人民邮电出版社 出版。}
之间存在着千丝万缕的关系，在 Haskell 中，这里就不介绍了。这里只展示一个 Haskell 中的现象
\footnote{seq 函数为一个求值函数。}
。
\begin{spec}
Prelude> let xs = map (2*) [1..10] :: [Int]
Prelude> :sprint xs
xs = _
Prelude> length xs
10
Prelude> :sprint xs
xs = [_,_,_,_,_,_,_,_,_,_]
Prelude> let ys = map (2*) [1..10] :: [Int]
Prelude> seq ys ()
()
Prelude> :sprint ys
ys = _ : _
\end{spec}
这里求值的结果，准确的说是内存里面，和 C 等语言的结果是不同的。

这里直接说结论了，这几种求值策略是的 Haskell 重要特性，可以提升运行效率,同时与“响应式编程”有着密切的关系。

在此获取此文档源代码\attachfile{show.lhs}
\end{document}
