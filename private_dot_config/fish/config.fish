# Load custom commands
source ~/.custom_commands
# Set PATH variables
set -x PATH /Library/Frameworks/Python.framework/Versions/3.10/bin $PATH
set -x PATH /Users/almaz5200/.mint/bin $PATH
set -x PATH /Users/almaz5200/flutter/bin $PATH
set -x PATH /Users/almaz5200/mybin $PATH
set -x PATH /opt/homebrew/bin $PATH
set -x PATH /Users/almaz5200/.cargo/bin $PATH
set -gx PATH ~/.tmuxifier/bin $PATH

set -x EDITOR nvim

set -x TMUXIFIER_LAYOUT_PATH "$HOME/.tmux-layouts"

# Define aliases
alias vim='nvim'

alias rnvim='/opt/homebrew/bin/nvim'
alias nnvim='/usr/local/bin/nvim'
alias nvim='nnvim'

alias lg='lazygit'
alias ce='chezmoi edit --apply'
alias sourcekit-lsp='xcrun sourcekit-lsp'

alias evenv='source .venv/bin/activate.fish'
alias mvenv='python3.11 -m venv .venv'
alias pifr='pip freeze > requirements.txt'
alias protpy='protoc --python_betterproto_out=. protos/*.proto'
alias cf='find . -type f | wc -l'
alias rld='source ~/.config/fish/config.fish'
alias wakatime='wakatime-cli'
alias sv='git add .;git commit -am "WIP"'

eval (tmuxifier init - fish)

# Initialize starship for fish
# starship init fish | source
fish_vi_key_bindings

function program_installed
    return (type $argv[1] > /dev/null 2>&1)
end

# test if zoxide is instaled in location agnostic way
if program_installed zoxide
    zoxide init fish | source
end

if program_installed rbenv
    status --is-interactive; and rbenv init - fish | source
end
# mise activate fish | source
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/almaz5200/anaconda3/bin/conda
    eval /Users/almaz5200/anaconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
set -U async_prompt_functions _pure_item_wakatime _pure_prompt_git
