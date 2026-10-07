if status is-interactive
    # Commands to run in interactive sessions can go here
end



fnm env --use-on-cd | source

starship init fish | source
zoxide init fish | source
direnv hook fish | source

abbr teams-for-linux "teams-for-linux --disable-gpu"
abbr sf "source ~/.config/fish/config.fish"
abbr auto-suspend-off "xset s off -dpms"
abbr auto-suspend-on "xset s on +dpms"
abbr sai "sudo apt install"
abbr agy "agy --model gemini-3.1-pro-high"




# Added by Antigravity CLI installer
set -gx PATH "/home/socialdroids/.local/bin" $PATH
