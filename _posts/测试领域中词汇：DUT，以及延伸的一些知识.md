---
title: 测试领域中词汇：DUT，以及延伸的一些知识
date: 2021/7/27 10:07:00
comments: true
tag: 
  - 测试
categories:
  - [IT笔记,测试]
keywords:
  - DUT
  - EUT
  - UUT
---

被测器件（DUT），也称为被测设备（EUT）和被测单元（UUT），是在首次制造时或在其生命周期后期进行测试的制造产品，作为正在进行的功能测试和校准的一部分检查。这可以包括修复后的测试，以确定产品是否按照原始产品规格执行。

在半导体测试中，DUT表示晶圆或最终封装部件上的特定管芯小片。利用连接系统将封装部件连接到手动或自动测试设备（ATE），ATE会为其施加电源，提供模拟信号，然后测量和估计器件得到的输出，以这种方式测定特定被测器件的好坏。

更多的情况下，DUT用于表示任何被测电子装置。例如，装配线下线的手机中的每一芯片都会被测试，而手机整机会以同样的方式进行最终的测试，这里的每一部手机都可以被称作DUT。DUT常以测试针组成的针床测试台连接到ATE。

> ## What Does Device Under Test (DUT) Mean?
>
> A device under test (DUT) is a device that is tested to determine performance and proficiency. A DUT also may be a component of a bigger module or unit known as a unit under test (UUT). A DUT is checked for defects to make sure the device is working. The testing is designed to prevent damaged devices from entering the market, which also may reduce manufacturing costs.
>
> A DUT is usually tested by automatic or automated test equipment (ATE), which may be used to conduct simple or complex testing, depending on the device tested. ATEs may include testing performed on software, hardware, electronics, semiconductors or avionics.
>
> ## Techopedia Explains Device Under Test (DUT)
>
> The majority of high-tech ATE structures utilize automation for quick test execution. Automation uses IT and control systems to limit human interaction. Depending on the module used during testing, the DUT can be attached to the ATE using a variety of connectors, such as pogo pins, a bed of nails tester, microscopic needles and zero insertion force (ZIF) sockets or contactors.
>
> Because there are a wide variety of DUTs, testing procedures vary. However, in all DUT testing, if a first out-of-tolerance value is identified, the testing stops immediately and the DUT fails the assessment.
>
> There are different DUT testing types. Such testing is applied to semiconductors, overall electronics or other devices.

[device-under-test-dut](https://www.techopedia.com/definition/25924/device-under-test-dut)

![dut_mydesk](https://oss.xknife.net/dut_mydesk.jpg)