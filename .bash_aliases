# use brew coreutils ls if it exists
if [ -n "$(command -v gls)" ]; then
	alias ls='gls --color=auto'
else
	alias ls='ls --color=auto'
fi