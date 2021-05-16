---
title: UnitOfWork设计模式之理解
date: 2021/5/8 16:04:00
comments: true
tag: 
  - UnitOfWork
  - 设计模式
categories:
  - [IT笔记,C#]
keywords:
  - UnitOfWork
  - 设计模式
  - EF
  - EntityFramework
  - EntityFrameworkCore
  - C#
  - Repository
---

```
个人学习笔记。文字与图片均网络收集后整理。如有侵权，请与笔者联系，笔者会在第一时间删除。
更新历史：
   - 2021年5月8日 创建笔记
```

![Repository-ve-UnitOfWork-Pattern](https://oss.xknife.net/Repository-ve-UnitOfWork-Pattern.png)

> *Maintains a list of objects affected by a business transaction and coordinates the writing out of changes and the resolution of concurrency problems.*
>
> For a full description see [P of EAA](https://martinfowler.com/books/eaa.html) page **184**
>
> ![img](https://martinfowler.com/eaaCatalog/unitOfWorkInterface.gif)
>
> When you're pulling data in and out of a database, it's important to keep track of what you've changed; otherwise, that data won't be written back into the database. Similarly you have to insert new objects you create and remove any objects you delete.
>
> You can change the database with each change to your object model, but this can lead to lots of very small database calls, which ends up being very slow. Furthermore it requires you to have a transaction open for the whole interaction, which is impractical if you have a business transaction that spans multiple requests. The situation is even worse if you need to keep track of the objects you've read so you can avoid inconsistent reads.
>
> A Unit of Work keeps track of everything you do during a business transaction that can affect the database. When you're done, it figures out everything that needs to be done to alter the database as a result of your work.

#### 关于Unit of Work模式

Unit Of Work的定义：Unit of Work是用来解决领域模型存储和变更工作，在ORM进行持久化的时候，比如Entity Framework的SaveChanges操作，其实就可以看做是Unit Of Work，也就是定义中所说“用来解决领域模型存储和变更工作”，但是如果项目是基于Entity Framework进行DDD（领域驱动设计）开发设计的，那Entity Framework中的Domain Model就必然包含业务逻辑，这就不符合“而这些数据层业务并不属于领域模型本身具有的”，也就是说Unit Of Work必须独立于Domain Layer（领域层），注意独立的业务是“数据层”业务，并不是业务场景中的“业务”，比如“转账业务”，转出方扣钱和转入方加钱这个业务就属于“数据层业务”，有的人会把Unit Of Work放在Domain Layer（领域层）中，其实是有些不恰当的，应该是放在Infrastructure Layer（基础层）中，但其实也只是相对而言，如果涉及到具体的业务单元模块，具体实现可以放在领域层中。

我们再看一个现实中例子，也最能说明Unit Of Work所包含的意思，就是银行转账操作，包含两个动作：转出方扣钱和转入方加钱，这两个动作要么都完成，要么都不完成，也就是事务操作，完成就Commit（提交），完不成就Rollback（回滚）。

在DDD（领域驱动设计）开发设计中，Unit Of Work的使用一般会结合Repository（仓储）使用。

#### 关于Repository模式

定义（来自Martin Fowler的《企业应用架构模式》）：

Mediates between the domain and data mapping layers using a collection-like interface for accessing domain objects.

个人理解：Repository是一个独立的层，介于领域层与数据映射层（数据访问层）之间。它的存在让领域层感觉不到数据访问层的存在，它提供一个类似集合的接口提供给领域层进行领域对象的访问。Repository是仓库管理员，领域层需要什么东西只需告诉仓库管理员，由仓库管理员把东西拿给它，并不需要知道东西实际放在哪。

[tabbycat](http://www.cnblogs.com/tabbycat/)的理解（[来源](http://www.cnblogs.com/tabbycat/archive/2010/01/24/1655447.html)）：

> 1. Repository模式是架构模式，在设计架构时，才有参考价值；
>
> 2. Repository模式主要是封装数据查询和存储逻辑；
>
> 3. Repository模式实际用途：更换、升级ORM引擎，不影响业务逻辑；
>
> 4. Repository模式能提高测试效率，单元测试时，用Mock对象代替实际的数据库存取，可以成倍地提高测试用例运行速度。
>
> 评估：应用Repository模式所带来的好处，远高于实现这个模式所增加的代码。只要项目分层，都应当使用这个模式。

关于泛型Repository接口（[来源](http://www.cnblogs.com/carysun/archive/2009/03/20/Repository.html#1506339)）：

> 仅使用泛型Repository接口并不太合适，因为Repository接口是提供给Domain层的操作契约，不同的entity对于Domain来说可能有不同的操作约束。因此Repository接口还是应该单独针对每个Eneity类来定义。
>
> 泛型的Repository<T>类仍然用来减少重复代码，只是不能被UserRepository类直接继承，因为这样Delete方法将侵入User类，所以改为在UserRepository中 组合一个Repository<T>，将开放给domain可见且又能使用泛型重用的功能委托给这个Repository<T>

Repository与Dal的区别（[来源](http://www.cnblogs.com/carysun/archive/2009/03/20/Repository.html#1506362)）：

> Repository是DDD中的概念，强调Repository是受Domain驱动的，Repository中定义的功能要体现Domain的意图和约束，而Dal更纯粹的就是提供数据访问的功能,并不严格受限于Business层。
>
> 使用Repository，隐含着一种意图倾向，就是 Domain需要什么我才提供什么，不该提供的功能就不要提供，一切都是以Domain的需求为核心；而使用Dal，其意图倾向在于我Dal层能使用的数 据库访问操作提供给Business层，你Business要用哪个自己选。换一个Business也可以用我这个Dal，一切是以我Dal能提供什么操 作为核心。

相关英文文章：

　　[Using Repository and Unit of Work patterns with Entity Framework 4.0](http://blogs.msdn.com/b/adonet/archive/2009/06/16/using-repository-and-unit-of-work-patterns-with-entity-framework-4-0.aspx)

　　[Implementing Repository Pattern With Entity Framework](http://www.codeproject.com/KB/database/ImplRepositoryPatternEF.aspx)

　　[Using the Entity Framework Repository and UnitOfWork Pattern in C# ASP .NET](http://www.primaryobjects.com/CMS/Article122.aspx)

　　[Revisiting the Repository and Unit of Work Patterns with Entity Framework](http://blogs.microsoft.co.il/blogs/gilf/archive/2010/06/21/revisiting-the-repository-and-unit-of-work-patterns-with-entity-framework.aspx)

　　[Do we need to use the Repository pattern when working in ASP.NET MVC with ORM solutions?](http://stackoverflow.com/questions/4724345/do-we-need-to-use-the-repository-pattern-when-working-in-asp-net-mvc-with-orm-sol)

　　[We have IQueryable, so why bother with a repository](http://weblogs.asp.net/cibrax/archive/2011/05/05/we-have-iqueryable-so-why-bother-with-a-repository.aspx)

　　[Crazy Talk: Reducing ORM Friction](http://blog.wekeroad.com/blog/crazy-talk-reducing-orm-friction/)　　

推荐代码示例：

　　[Microsoft - Domain Oriented N-Layered .NET 4.0 App Sample (DDD Architecture)](http://microsoftnlayerapp.codeplex.com/)

相关博文：

　　[EntityFramework之领域驱动设计实践（七）-模型对象的生命周期 - 仓储](http://www.cnblogs.com/daxnet/archive/2010/07/07/1772638.html)

　　[EntityFramework之领域驱动设计实践（八）- 仓储的实现：基本篇](http://www.cnblogs.com/daxnet/archive/2010/07/07/1772780.html)

> [UnitOfWork知多少 - 云+社区 - 腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1505237)
>
> [关于Repository模式 - dudu - 博客园 (cnblogs.com)](https://www.cnblogs.com/dudu/archive/2011/05/25/repository_pattern.html)