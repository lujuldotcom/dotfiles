HISTFILE=~/.local/state/zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt inc_append_history
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_expire_dups_first

setopt globdots
setopt extended_glob
setopt interactive_comments
setopt prompt_subst

# -------------------
# START PROMPT CONFIG
# -------------------

autoload -Uz vcs_info
setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' formats '󰘬 %b'
zstyle ':vcs_info:git:*' actionformats '󰘬 %b | %a'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' max-exports 1
zstyle ':vcs_info:git:*' check-for-changes false

GIT_DIRTY_ASYNC=""
GIT_DIRTY_JOB=0

function update_git_dirty_async() {
  (( GIT_DIRTY_JOB > 0 )) && kill $GIT_DIRTY_JOB 2>/dev/null

  {
    local dirty=""
    if [[ -n $vcs_info_msg_0_ ]]; then
      if git rev-parse --is-inside-work-tree &>/dev/null; then
        git diff --quiet 2>/dev/null || dirty=1
        git diff --cached --quiet 2>/dev/null || dirty=1
        [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]] && dirty=1
      fi
    fi
    [[ $dirty -eq 1 ]] && echo "" || echo ""
  } | { read val; GIT_DIRTY_ASYNC="$val"; }

  GIT_DIRTY_JOB=$!
}

precmd() {
  vcs_info
  update_git_dirty_async
  print -Pn "\e]0;%~ ${vcs_info_msg_0_} ${GIT_DIRTY_ASYNC}\a"
}

PROMPT='%F{yellow}%n%f@%F{white}%m%f %F{blue}%~%f %F{cyan}${vcs_info_msg_0_}%f %F{magenta}${GIT_DIRTY_ASYNC}%f
 '

# -------------------
# END  PROMPT  CONFIG
# -------------------

autoload -Uz compinit
zmodload zsh/complist

if [[ ! -f ~/.config/zsh/.zcompdump ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' menu select

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

alias vi='nvim'
alias vim='nvim'

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias la='ls -lha --color=auto --group-directories-first'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias tree='tree -C'

alias reboot='systemctl reboot --no-wall'
alias poweroff='systemctl poweroff --no-wall'

alias music='setsid st -c ncmpcpp-7 -e ncmpcpp >/dev/null 2>&1 < /dev/null && echo "ncmpcpp launched on tag 7"'
alias yt='setsid st -c yt-7 -e yt-x >/dev/null 2>&1 < /dev/null && echo "yt-x launched on tag 7"'

ZSH_DIR="$(cd "$(dirname "$(realpath "${(%):-%x}")")" && pwd)"
SCRIPTS_DIR="$ZSH_DIR/../../scripts"
hdmi() {
  "$SCRIPTS_DIR/hdmi.sh" "$@"
}
video() {
    setsid mpv --x11-name=mpv-7 --no-terminal "$@" >/dev/null 2>&1 </dev/null && echo "mpv launched on tag 7"
}

passlogin() {
    pass show "$1" | grep '^login:' | cut -d' ' -f2- | tee >(xclip -selection clipboard)
}
compdef passlogin=pass

sudo() {
    if [[ "$1" == "vi" || "$1" == "vim" || "$1" == "nvim" ]]; then
        shift
        sudoedit "$@"
    else
        command sudo "$@"
    fi
}

eval "$(fnm env --use-on-cd --shell zsh)"

export GPG_TTY=$(tty)

bindkey '\e[3~' delete-char
