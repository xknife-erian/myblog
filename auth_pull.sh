#!/bin/sh
unset GIT_DIR
Path="/home/git/myblog"
cd $Path
git pull
cd /home/blog
hexo clean && hexo d
exit 0
