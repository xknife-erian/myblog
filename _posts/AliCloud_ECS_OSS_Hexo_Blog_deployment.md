---
title: Hexo,ECS,OSS,Nginx;Blog搭建笔记
date: 2021/1/8 18:00:00
comments: true
tag: 
  - Unbantu
  - blog
  - hexo
  - nginx
categories:
  - [笔记, linux]
---

![Workbench with a little clutter and warmth](http://oss.xknife.net/Workbench_with_a_little_clutter_and_warmth.jpg)

其实很久以前，应该在2002年前后，就已经建立的自己的博客（或者说是个人网站），但是一是服务器太贵，二是网站的内容模式不清晰，所以隔上一两年就歇下了。在两三年前，2018年前后，阿里的服务器很便宜了，便又生出了建立一个Blog的想法，用wordpress进行了搭建，成功后，陆续写了两三个月，但是各种墙啊，导致字体等等问题，网站很慢，更新备份也极不方便，显而易见，又放弃了。

在这中间，考察了各种网站，知乎，简书，CSDN等等，都不合意，要么太偏向专业，要么主题太丑或者太麻烦，这些呢唯二的好处是，一是可以带来流量；二是不用交钱。但这两点对我并不重要。我的Blog无需流量，流量太大我还得花钱；通用平台替我省的钱说实话我也不太在乎。这次一口气交了5年的服务器费用，其实各种用券和优惠后还是不贵，好象是6百多。

好了闲话少说。现将这台服务器部署的笔记记录如下。

#### 需求分析：blog维护流程与技术链设计

1. Linux系统，使用Ubuntu20.04操作系统；阿里云ECS；
2. Web服务器采用nginx；支持多个网站；
3. Blog使用Hexo做为生成器；静态网站；
4. Blog内容使用markdown独立文档，上传到github项目，当有上传事件时，通过webhook触发服务器自动pull, pull完成后自动调用hexo生成网站；
5. markdown内容采用typora软件进行撰写，插入的图片会自动上传到阿里云的oss；

#### 准备工作

1. 申请阿里云ECS
2. 申请阿里云OSS

#### 部署笔记

1. ECS使用Ubuntu20.04镜像

2. ssh远程登录服务器

3. 服务器源更新，基础更新

   ```
   sudo apt-get update
   sudo apt-get upgrade
   ```

4. 安装 Git：  `sudo apt-get install git`

5. 安装 nodejs，官网有详细安装步骤： `https://github.com/nodesource/distributions`

   ```
   # Latest LTS Version: 14.15.3 (includes npm 6.14.9)
   # Using Ubuntu
       curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
       sudo apt-get install -y nodejs
   ```

6. 安装cnpm，不改变npm的默认源，以保证特殊情况下可以使用

   ```
   // 安装cnpm命令,不会改变npm的源
   npm install -g cnpm --registry=https://registry.npm.taobao.org
   // 查看npm源
   npm config get registry
   ```

7. 安装 nginx `sudo apt-get install nginx`

8. 安装 hexo : [参考官方文档](https://hexo.io/zh-cn/docs/)

   ```
   cnpm install -g hexo-cli
   ```

9. 使用hexo-cli初始化第一个网站

   ```
   $ cd /home
   $ hexo init www_xknife
   $ cd www_xknife
   $ npm install
   ```

10. 在Home目录下建立Git的工作目录，方便clone一些源代码

    ```
    mkdir git-codes
    git clone https://github.com/xknife-erian/myblog.git # 我的blog内容存储项目
    ```

11. 可以设置hexo主题，也可以不设置，主题的设置各不相同，不在本文论述，一般来讲看各个主题的帮助文档按自己需要设置即可。

12. 配置hexo，重点是内容的路径，要指向第10步的git库

    ```
    source_dir: /home/git-codes/myblog
    ```

13. 生成静态网站

    ```
    cd /home/www_xknife
    hexo clean && hexo g
    ```

14. 配置nginx的路径

    ```
    cd /etc/nginx/sites-available
    vim defalut
    ```

    ```
    // 修改配置文件中的 root 路径
    root /home/www_xknife/public;
    ```

15. 安装webhook

    因为webhook是Go语言开发的，所以要先安装Go语言。

    ```shell
    sudo apt-get install -y golang
    ```

    安装webhook，在开机服务中会被自动安装

    ```shell
    sudo apt-get install webhook
    ```

16. 配置webhook

    首先配置webhook的启动配置，配置文件可以放在任意位置，下一步在配置守护进程时指向该路径即可

    ```
    vim hook.json
    ```

    ```json
    [
       {
          "id": "git-webhook",
          "execute-command": "/home/git-codes/auth_pull.sh",
          "command-working-directory": "/home/git-codes/"
       }
    ]
    ```

    然后建立命令文件，做为webhook响应时的调用

    ```sh
    #!/bin/sh
    unset GIT_DIR
    Path="/home/git-codes/myblog" # blog内容所在的github库更新的路径
    cd $Path
    git pull #从github更新
    cd /home/www_xknife #hexo所在位置
    hexo clean && hexo d #hexo清理后并更新
    exit 0
    ```

17. 在GitHub设置webhook

    ![](http://oss.xknife.net/github-webhook.jpg)

    - 注意事项1：hook.json中的id和在github设置的URL最后字段要一致
    - 注意事项2：所有的路径要设置正确
    - 注意事项3：github中的Secret可以不填写

18. 查看开机启动的服务：

    ```bash
    // 开机启动的服务列表
    systemctl list-unit-files --type=service|grep enabled
    // 查看某服务的详细状态
    systemctl status xx.....xx.service
    ```

19. 安装进程守护服务：[supervisord](http://supervisord.org/)

    ```
    sudo apt-get install supervisor
    ```

    配置：

    ```shell
    cd /etc/supervisor/conf.d #配置所在的目录
    #新增webhook.conf配置文件，做为webhook的启动配置
    vim webhook.conf
    ```

    ```shell
    #supervisorctl 来管理进程时需要使用该进程名
    [program:webhook]
    directory=/home/git-codes           ; 程序的启动目录
    command=webhook -hooks /home/git-codes/hooks.json -verbose    ; 启动命令 最好绝对路径
    autostart = true                      ; 在 supervisord 启动的时候也自动启动
    numprocs=1                            ; 默认为1
    process_name=%(program_name)s         ; 默认为 %(program_name)s，即 [program:x] 中的 x
    user=root                             ; 使用 root 用户来启动该进程
    autorestart=true                      ; 程序崩溃时自动重启，重启次数是有限制的，默认为3次
    redirect_stderr=true                  ; 重定向输出的日志
    stdout_logfile=/home/git-codes/github-webhook.log
    loglevel=warn
    ```

    注意：command的值的设定，要将第16步设置的webhook的配置文件路径填写正确。

20. 配置nginx + https

