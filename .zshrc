# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/sebastiaan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
alias cat="batcat"
alias ping="gping"
alias gitignore="
    find '.gitignore$' \"$HOME/github.com/github/gitignore\" \
        | sed 's/\.gitignore$//' \
        | fzf +s -m -d '/' --with-nth=-1 \
        | xargs -I@ cat '@.gitignore' \
        >> .gitignore
"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source /home/sebastiaan/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/sebastiaan/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
if [ -e /home/sebastiaan/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sebastiaan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

eval $(thefuck --alias)
alias fk=fuck
alias dc="docker-compose"

export CHROME_EXECUTABLE=~/.local/share/flatpak/exports/bin/org.chromium.Chromium
export ANDROID_SDK_ROOT=~/Android/Sdk

youtube-dl-fix(){
    (cd ~/github.com/CNugteren/youtube-dl && python -m youtube_dl $@)
}

# youtube-dl alias
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

clone () {
    prefix='https://'
    link="${1#"$prefix"}" 
    websiteUserAndRepo=($(echo "${link}" | tr '/', '\n'))
    website=${websiteUserAndRepo[1]}
    user=${websiteUserAndRepo[2]}
    repo=${websiteUserAndRepo[3]}
    cd ~/${website}/
    mkdir -p ${user}
    cd ${user}
    git clone git@${website}:${user}/${repo}.git
    cd ~/${website}/${user}/${repo}
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

export PATH="$HOME/.poetry/bin:$PATH"
