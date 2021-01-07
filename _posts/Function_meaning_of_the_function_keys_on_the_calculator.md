---
title: 计算器上的功能键的功能含义
date: 2018-06-20 17:32:41
comments: true
tag: 
  - 编程
  - python
  - 计算器
categories:
- [笔记, 软件]
---

![casio_fx991cnx](http://oss.xknife.net/casio_fx991cnx.jpg)

　　最近在学习python。随着NumPy, SciPy, Matplotlib等众多程序库的开发，Python越来越适合于做科学计算、绘制高质量的2D和3D图像，在多数情况下可替代科学计算领域最流行的商业软件Matlab。以我的习惯，会给自己定义一个课题项目，通过课题项目在练习、设计过程中学习与提高。那么如何即充分发挥python的强项，又能兼容数学，UI，面向对象的程序设计等多个角度呢？反复思考，打算开发一个科学(数学)计算器。计划2-3个月业余完成。

　　课题制定后，拿起一个普通的计算器，而那些高级的计算器上的功能更加复杂，每个键的定义更加丰富，而这些功能竟然不知道是干什么用的。
　　火速网上搜了一下，只找到一些初级计算器的功能说明，整理如下：

<ul>
<li><strong>Backspace</strong>：退格，删除当前输入数字中的最后一位</li>
<li><strong>CE</strong>：清除，清除显示的数字。</li>
<li><strong>C</strong>：归零，清除当前的计算。</li>
<li><strong>MC</strong>：清除存储器中的数值。</li>
<li><strong>MR</strong>：将存于存储器中的数显示在计算器的显示框上。</li>
<li><strong>MS</strong>：将显示框的数值存于存储器中。如果存储器中有数值将会显示M标志。</li>
<li><strong>M+</strong>：将显示框的数与存储器中的数相加并进行存储。</li>
<li><strong>Sqrt</strong>：计算显示数字的平方根。</li>
<li><strong>%</strong>：①表示某个数的百分比。</li>
<li><strong>Ave</strong>：计算统计框中各数的平均值。若要计算平均方值，请使用Inv+Ave。</li>
<li><strong>Sum</strong>：计算统计框中各数的和。若要计算平方和，请使用Inv+Sum。</li>
<li><strong>S</strong>：计算n-1个样本参数的标准偏差。若要计算n个样本参数为的标准偏差，请使用Inv+s。</li>
<li><strong>Dat</strong>：将显示框中的数值装载到统计框中。</li>
<li><strong>F-E</strong>：打开或关闭科学计数法。大于10^32的数总是以指数形式表示。F-E只能用于十进制数字系统。</li>
<li><strong>Dms</strong>：将显示数字转换为度-分-秒格式（假设显示数字是用度数表示的）。若要将显示数字转换为用度数表示的格式（假设显示数字是用度-分-秒格式表示的），请使用Inv+dms。dms只能用于十进制数字系统。</li>
<li><strong>Sin</strong>：计算显示数字的正弦。若要计算反正弦，请使用Inv+sin。若要计算双曲正弦，请使用Hyp+sin。若要计算反双曲正弦，请使用Inv+Hyp+sin。sin只能用于十进制数字系统。</li>
<li><strong>Cos</strong>：cos计算显示数字的余弦。若要计算反余弦，请使用Inv+cos。若要计算双曲余弦，请使用Hyp+cos。若要计算反双曲余弦，请使用Inv+Hyp+cos。cos只能用于十进制数字系统。</li>
<li><strong>Tan</strong>：计算显示数字的正切。若要计算反正切，请使用Inv+tan。若要计算双曲正切，请使用Hyp+tan。若要计算反双曲正切，请使用Inv+Hyp+tan。tan只能用于十进制数字系统。</li>
<li><strong>Exp</strong>：允许输入用科学计数法表示的数字。指数限制为四位数。指数中只能使用十进制数（键0-9）。Exp只能用于十进制数字系统。</li>
<li><strong>x^y</strong>：计算x的y次方。此按钮为二进制运算符。例如，若要计算2的4次方，请单击2x^y4=，结果为16。若要计算x的y次方根，请使用Inv+x^y。</li>
<li><strong>x^3</strong>：计算显示数字的立方。若要计算立方根，请使用Inv+x^3。</li>
<li><strong>x^2</strong>：计算显示数字的平方。若要计算平方根，请使用Inv+x^2。</li>
<li><strong>ln</strong>：计算自然对数（以e为底）。若要计算e的x次方（其中x是当前数字），请使用Inv+ln。</li>
<li><strong>log</strong>：计算常用对数（以10为底）。若要计算10的x次方，请使用Inv+log。</li>
<li><strong>n!</strong>：计算显示数字的阶乘。</li>
<li><strong>Pi</strong>：显示π的值（3.1415...）。若要显示2*pi（6.28...），请使用Inv+pi。pi只能用于十进制数字系统。</li>
<li><strong>Mod</strong>：显示x/y的模数或余数。</li>
<li><strong>And</strong>：计算按位AND。逻辑运算符在执行任何按位运算时将截断数字的小数部分。</li>
<li><strong>Or</strong>：计算按位OR。逻辑运算符在执行任何按位运算时将截断数字的小数部分。</li>
<li><strong>Xor</strong>：计算按位异OR。逻辑运算符在执行任何按位运算时将截断数字的小数部分。</li>
<li><strong>Lsh</strong>：左移。若要右移，请使用Inv+Lsh。在单击该按钮后，必须指定（以二进制形式）要将显示区中的数字左移或右移多少位，然后单击=。逻辑运算符在执行任何按位运算时将截断数字的小数部分。</li>
<li><strong>Not</strong>：计算按位取反。逻辑运算符在执行任何按位运算时将截断数字的小数部分。</li>
<li><strong>Int</strong>：显示十进制数值的整数部分。若要显示十进制数值的小数部分，请使用Inv+Int。</li>
<li><strong>ABCDEF</strong>：在数值中输入选中字母（只有在十六进制模式为开启状态时该按钮才可用）。</li>
</ul>