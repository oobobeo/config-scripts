# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/sakura/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gentoo"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# GO
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# RBENV
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export EDITOR='vim'


#########  alias  ##########
alias ls='ls --color -A'
alias grep='grep --color=auto --exclude-dir={.git}'





alias cdop='cd ~/op'
alias cdss='cd ~/op/sakura-server-1'
alias cdss1='cd ~/op/sakura-server-1'
alias cdss2='cd ~/op/sakura-server-2'
alias cdss3='cd ~/op/sakura-server-3'
alias cdss4='cd ~/op/sakura-server-4'

alias cdsr='cd ~/op/sakura-resource-zh-TW'
alias cdsa='cd ~/op/sakura-archive-all'
alias cdsm='cd ~/op/sakura-master-data'
alias cdol='cd ~/op/op-local-tools'
alias cdy='cd ~/op/yoshino'
alias cdsas='cd ~/op/sakura-archive-script'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//    ;s/[;&|]\s*alert$//'\'')"'

alias crch="\\git status --porcelain | \\grep -e 'M  ' -e 'A  ' | \\cut -d ' ' -f 3 | \\grep '\\.png$' | \\xargs -i -P8 crunch \"{}\""
alias crchd="\\git status --porcelain | \\grep -e 'MM ' -e 'AM ' | \\cut -d ' ' -f 2 | \\grep '\\.png$' | \\xargs -i -P8 crunch \"{}\""
alias crch-all="crch && crchd && crchd && crchd && crchd && git add ."

# cp last commit's changes into HAYATE
alias    cplc="git show --name-only --format=%H | \grep server/ | xargs -I '{}' echo cp --parent \"{}\" ~/op/HAYATE/sakura-resource-zh-TW"
alias cplc-do="git show --name-only --format=%H | \grep server/ | xargs -I '{}'      cp --parent \"{}\" ~/op/HAYATE/sakura-resource-zh-TW"

# force vi to open latest version(8.2) of vim
alias vi='vim'

# ALERT
alias alert='echo -e "\a"'






########  git  ##########
# short aliases
alias gs='git status'
alias pull='git pull'
alias add='git add .'
alias commit='git commit'
alias push='git push'
########################

# git-xlsx-textconv
alias xl='/home/sakura/go/bin/git-xlsx-textconv'

# git diff of (index->workspace)
alias gdc='git diff --cached'
# git diff --cached for excel files
alias gdcx='git diff --cached -b -U0 --color-words --word-diff-regex=.'

# git diff of (HEAD->index) 
alias gd='git diff'
#git diff for excel files
alias gdx='git diff -b -U0 --color-words --word-diff-regex=.'

# ssh로 붙었을 때 유니코드 문자 잘 나오게 하자
alias ssh='LC_ALL=ko_KR.UTF-8 LANGUAGE=ko_KR.UTF-8 ssh'

# enter tmux if not already running 
# then run tmuxinator
if [ -z "$TMUX" ]; then
    tmux attach || tmux
fi
sleep 1
if [[ $TMUX_PANE == "%0" ]];then
	tmuxinator start op
fi
export HISTTIMEFORMAT="%d/%m/%y %T "

HISTTIMEFORMAT="%d/%m/%y %T " 
alias history='omz_history -f | less'

# MY SCRIPTS
alias clo='~/op/config-scripts/clean_op.sh'
alias sandbox='~/op/config-scripts/sandbox_setup.sh'
alias xlsxgrep='~/op/config-scripts/xlsxgrep.sh '
alias pa='~/op/config-scripts/pull_all_repos.sh' 
