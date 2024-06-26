# zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin/:$PATH
export PATH=$HOME/.config/nextinit:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/bin/flutter/bin:$PATH
export PATH=$HOME/.docker/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/Users/sebastiaanjansen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

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

alias cat="bat"
alias ping="gping"
#function gitignore() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}
alias gitignore="
    find '.gitignore$' \"$HOME/github.com/github/gitignore\" \
        | sed 's/\.gitignore$//' \
        | fzf +s -m -d '/' --with-nth=-1 \
        | xargs -I@ cat '@.gitignore' \
        >> .gitignore
"
alias dc="docker compose"
alias tree="tree -C"
alias tre='tree -CL 2'
alias ls="exa --icons"
alias pull="git pull --rebase"
alias fetch="git fetch --all --prune"
# alias run=
run () {
  echo $0
  if [ -z "$1" ];  then
    jq '.scripts | keys[]' package.json | fzf | xargs npm run
  else
    npm run $1
  fi
}

test -r "~/.dir_colors" && eval $(gdircolors ~/dircolors.ansi-light)

mp3 () {
    youtube-dl --ignore-errors -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s' "$1"
}

mp3p () {
    youtube-dl --ignore-errors --sleep-interval 30 -i -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "$1"
}

dlv () {
    youtube-dl --ignore-errors -o '%(title)s.%(ext)s' "$1"
}

dlp () {
    youtube-dl --yes-playlist --ignore-errors --sleep-interval 30 -o '%(playlist)s/%(title)s.%(ext)s' "$1"
}

repo () {
        local url=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
        if [[ $url == "" ]]
        then
                echo "Not a git repository or no remote.origin.url is set."
        else
                local branch=$(git rev-parse --abbrev-ref HEAD)
                local url="http:${url}"
                if [[ $branch != "master" ]]
                then
                        local url="${url}/tree/${branch}"
                fi
                echo $url
                open $url
        fi
}

repo2() {
  local ssh_url=$(git config --get remote.origin.url)
  local https_url

  # Check if the URL is a valid SSH Git URL.
  if [[ "$ssh_url" = git@* ]]; then
    # Replace ':' with '/', 'git@' with 'https://' and remove .git at the end
    https_url=$(echo "$ssh_url" | sed -e 's/:/\//g' -e 's/^git@/https:\/\//' -e 's/\.git$//')
    open "$https_url"
  elif [[ "$ssh_url" == http* ]]; then
    open "$ssh_url"
  else
    echo "Invalid SSH Git URL: $ssh_url" >&2
    return 1
  fi
}

clone () {
    cd $(smartclone $1 | tail -1)
}

clone2() {
  # Check for argument count
  if [ "$#" -ne 1 ]; then
    echo "Usage: clone <url>"
    return 1
  fi

  # Input URL
  input_url=$1

  # Parse the URL components
  scheme=$(echo "$input_url" | grep :// | sed -e's,^\(.*://\).*,\1,g')
  url_without_scheme=${input_url//$scheme/}
  hostname=$(echo "$url_without_scheme" | grep / | cut -d/ -f1)
  complete_path=$(echo "$url_without_scheme" | grep / | cut -d/ -f2 -f3)
  target_dir="$HOME/${hostname}/${complete_path}"

  # Check if directory exist
  if [ -d "$target_dir" ]; then
    # If the directory exists, cd to it.
    echo "$target_dir"
    cd "$target_dir" || exit # Exit if cd fails, usually due to permission issues.
    echo "Directory already exists, is it already cloned?"
    return 0
  else
    echo "Directory does not exist: $target_dir"
  fi

  # Navigate to the home directory
  # cd ~ || exit

  # Create and navigate to the target directory
  target_dir="$HOME/${hostname}/${complete_path}"
  target_dir_lower=$(echo "$target_dir" | tr '[:upper:]' '[:lower:]')
  mkdir -p "$target_dir_lower" || return

  # Clone the repository
  git clone ${input_url} ${target_dir_lower}
  echo "Cloned to ${target_dir_lower}"

  echo "$target_dir_lower"
}

svelte () {
  if (($#  == 0))
  then
    echo "Usage: svelte <project-name>"
    return 1
  fi
  echo "Initializing new svelte project with tailwind in $1"
  cd $(node ~/bin/svelte-init/index.mjs $1 | tail -1)
  code .
  npm run dev -- --open
}

svelterik () {
  if (($#  == 0))
  then
    echo "Usage: svelte <project-name>"
    return 1
  fi
  echo "Initializing new svelte project with tailwind and icons in $1"
  cd $(node ~/bin/svelte-icon-init/index.mjs $1 | tail -1)
  code .
  npm run dev -- --open
}

# clone () {
#     prefix='https://'
#     link="${1#"$prefix"}" 
#     websiteUserAndRepo=($(echo "${link}" | tr '/', '\n'))
#     website=($(echo ${websiteUserAndRepo[1]} | tr '[:upper:]' '[:lower:]'))
#     user=($(echo ${websiteUserAndRepo[2]} | tr '[:upper:]' '[:lower:]'))
#     repo=($(echo ${websiteUserAndRepo[3]} | tr '[:upper:]' '[:lower:]'))
#     echo "Cloning to ~/${website}/${user}/${repo}"
#     echo ${user}
#     cd ~/${website}/
#     mkdir -p ${user}
#     cd ${user}
#     git clone git@${website}:${user}/${repo}.git
#     cd ~/${website}/${user}/${repo}
#     if [[ "$user" = "tinkerlist" ]]; then
#         echo "Setting up Tinkerlist GIT config"
#         git config user.name "Sebastiaan Jansen"
#         git config user.email "sebastiaan@tinkerlist.tv"
#     fi
# }

export ANDROID_HOME=/Users/sebastiaanjansen/Library/Android/sdk
export ANDROID_SDK_ROOT=/Users/sebastiaanjansen/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

eval "$(fnm env --use-on-cd)"
alias nvm="fnm"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export ENHANCD_AWK=awk
export ENHANCD_USE_ABBREV=true
source ~/.oh-my-zsh/custom/plugins/enhancd/init.sh

# eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/sebastiaanjansen/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/sebastiaanjansen/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/sebastiaanjansen/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/sebastiaanjansen/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# bun completions
# [ -s "/Users/sebastiaanjansen/.bun/_bun" ] && source "/Users/sebastiaanjansen/.bun/_bun"

# Bun
# export BUN_INSTALL="/Users/sebastiaanjansen/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

# ESP Idf
# export IDF_PATH=~/esp/esp-idf
# export PATH=$HOME/esp/xtensa-esp32-elf/bin:$PATH
# export PATH="$IDF_PATH/tools:$PATH"
# export SDKROOT=$(xcrun --show-sdk-path --sdk macosx)

# pnpm
# export PNPM_HOME="/Users/sebastiaanjansen/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end
# bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
# zprof
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PICO_SDK_PATH=/Users/sebastiaanjansen/github.com/raspberrypi/pico-sdk
