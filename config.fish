set -U fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

fzf --fish | source

abbr l ll -a

alias vi='nvim'
alias vim='nvim'

abbr n nvim
abbr v nvim

abbr copy 'xclip -selection clipboard'
abbr clip 'xclip -selection clipboard'

abbr nr 'npm run'
abbr nrd 'npm run dev'

abbr f 'nnn -d -e -H -r'

abbr g lazygit
