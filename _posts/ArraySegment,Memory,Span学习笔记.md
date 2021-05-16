---
title: ArraySegment<T>、Memory<T>、Span<T>学习笔记
date: 2021/3/23 16:04:00
comments: true
tag: 
  - C#
categories:
  - [IT笔记,C#]
keywords:
  - ArraySegment<T>
  - Memory<T>
  - Span<T>
 
---

```
个人学习笔记。文字与图片均网络收集后整理。如有侵权，请联系笔者，会第一时间删除。
更新历史：
   - 2021/3/23 创建笔记
```

System.Span<T> 是核心 .NET 库提供 的一个新的**值类型**。它代表着一块已知长度的连续内存块，这个内存块可以关联到一个托管对象，可以是通过互操作获取的本机码，也可以是栈的一部分。**它提供了一个像访问数组那样安全地操作内存的方式**。 它非常类似 T[] 或 ArraySegment，它提供安全的访问内存区域指针的能力。其实我理解它是.NET中操作(void*)指针的抽象封装，熟悉C/C++开发者应该更明白这意味着什么。

Span的特点如下：

1. 抽象了所有连续内存空间的类型系统，包括：数组、非托管指针、堆栈指针、fixed或pinned过的托管数据，以及值内部区域的引用；
2. 支持CLR标准对象类型和值类型；
3. 支持泛型；
4. 支持GC，而不像指针需要自己来管理释放；

> 参考与学习过的文章：
>
> https://www.cnblogs.com/BigBrotherStone/p/memory-and-spans.html
>
> https://blog.csdn.net/wnvalentin/article/details/93485572