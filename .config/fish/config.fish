set -U fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

# fish_add_path ~/.local/bin

set -gx EDITOR nvim

abbr l ll -a
abbr b bat
abbr a amp --ide

alias cat='batcat'
alias bat='batcat'

alias fd='fdfind'

alias vi='nvim'
alias vim='nvim'

abbr n nvim
abbr v nvim

abbr copy 'xclip -selection clipboard'
abbr clip 'xclip -selection clipboard'

abbr t termdown
