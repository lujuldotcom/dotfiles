export VISUAL=nvim
export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME:-$HOME/.config}/git/gitconfig"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export CARGO_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/cargo"
export PATH="$CARGO_HOME/bin:$PATH"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
export YARN_CACHE_FOLDER="${XDG_CACHE_HOME:-$HOME/.cache}/yarn"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nvidia/ComputeCache"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export PATH="$GOPATH/bin:$PATH"
export GO_NO_TELEMETRY=1
export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/less/history"
export NODE_REPL_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/node/repl_history"

eval "$(fnm env --shell zsh)"

env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && . "$env" >|/dev/null; }

agent_start() {
    (
        umask 077
        ssh-agent >|"$env"
    )
    . "$env" >|/dev/null
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
    ssh-add -l >|/dev/null 2>&1
    echo $?
)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    while [ ! -c /dev/dri/card0 ]; do sleep 0.05; done
    exec startx &>/dev/null
fi
