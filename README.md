home
====

Linux home folder files.

Contains dot files for bash, bash profile and vim.

Currently all plugins are loaded using [NeoBundle](https://github.com/Shougo/neobundle.vim) so they
will have to be downloaded on first use.

SVN vimdiff
-----------

To use vimdiff for svn diff add this line to 
`~/.subversion/config`

```
[helpers]
diff-cmd = ~/.svndiffwrap.sh
```

Assuming that `.svndiffwrap.sh` has been symlinked from the home repo.
