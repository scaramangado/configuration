# Config repo
alias config='git --git-dir=$HOME/.config-repo/ --work-tree=$HOME'

### BASE SETUP

bindkey -e
PATH=~/.scripts:/usr/local/texlive/2020/bin/x86_64-linux:/usr/bin:/sbin:/usr/sbin:~/.local/bin:$PATH

# Theme

source ~/.config/zsh/themes/agnoster.zsh-theme

prompt_status() {
  if [[ $RETVAL -ne 0 ]]; then
    prompt_segment red $PRIMARY_FG " %{%F{black}%}✘ "
  fi;
}

prompt_context() {
  prompt_segment black default " %(!.%{%F{yellow}%}.)$(hostname -s) "
}

prompt_dir () {
  prompt_segment blue $PRIMARY_FG ' %c '
}

AGNOSTER_PROMPT_SEGMENTS=("prompt_context" "prompt_dir" "prompt_virtualenv" "prompt_git" "prompt_status" "prompt_end")

# Tab completion and auto cd

setopt auto_cd
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select

# Enable Ctrl-x-e to edit command line

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Fix keyboard

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# To generate the file: autoload zkbd && zkbd
[[ -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]] && source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char

# History

export SAVEHIST=100000
export HISTSIZE=100000
export HISTFILE=~/.zsh_history

setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

bindkey '^r' history-incremental-search-backward

# Misc

setopt multios
setopt prompt_subst
[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
# sudo pacman -S pkgfile && sudo pkgfile -u
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh
alias ls="ls --color=auto"
alias reset-bluetooth="[ \$(pgrep 'blu.*tray' | wc -l) -gt 1 ] && pgrep -o 'blu.*tray' | xargs kill ||:"

# Load addidiotnal configuration
PRIVATE_CONFIG="$HOME/.config/private"
WORK_CONFIG="$HOME/.config/work"
[ -f "$PRIVATE_CONFIG/init.zsh" ] && source "$PRIVATE_CONFIG/init.zsh"
[ -f "$WORK_CONFIG/init.zsh" ] && source "$WORK_CONFIG/init.zsh"

### BASE SETUP END

# Make neovim the default editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
alias vim="nvim"
alias vimwiki="vim -c ':VimwikiIndex'"

# Make 'clear' work correctly in urxvt
export TERMINAL_EMULATOR=$(ps -ho comm -p $(ps -ho ppid -p $$))
[ $TERMINAL_EMULATOR = 'urxvtd' ] && alias clear="echo -ne '\033c'"

# Utils
eval "$(dircolors ~/.dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias ll="ls -lAh"
alias l="ls -lh"
alias sudo="sudo "
alias scp="scp -T"
type batcat >/dev/null 2>&1 && alias bat="batcat"
alias dcup="sudo docker-compose up -d"
alias dcdown="sudo docker-compose down"

function ef() {
	$EDITOR $(fdfind --type f | fzf)
}

function vf() {
	bat EDITOR $(fdfind --type f | fzf)
}

# Git

source ~/.git-flow-completion.zsh
alias g-="git checkout -"
export PATH=$HOME/git_bin:$PATH

function repo {
	cd $(git rev-parse --show-toplevel)
}

# TheFuck

type thefuck >/dev/null 2>&1 && eval $(thefuck --alias)

# Syntax Highlighting

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('(?)-rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || echo -n

