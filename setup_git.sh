#!/bin/sh

git config --global user.email "sovereign250@gmail.com"
git config --global user.name "astrellon"

git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

git config --global push.default simple
