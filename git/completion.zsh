completion='$(brew --prefix)/share/zsh/site-functions/_git'

# Assumes git's bash `git-completion` script at $completion
if test -f $completion; then
  source $completion
fi
