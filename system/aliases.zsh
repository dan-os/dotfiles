#!/usr/bin/env bash

# directory shortcuts
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# week number
alias week='date +%V'

# system update
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# get local ip
alias myip='ipconfig getifaddr en0'

# flush dns cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# hide/show desktop icons (presenting)
alias hidedesk="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesk="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# http functions
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done

# kill all chromium tabs
alias killtabs="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# reload shell (invoke as login)
alias reload="exec ${SHELL} -l"

# pretty-print path
alias ppath='echo -e ${PATH//:/\\n}'
