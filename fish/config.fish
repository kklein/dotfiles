# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

# Run ssh_agent. This allows for the storage of keys
# for ssh profies.
# https://github.com/ivakyb/fish_ssh_agent
fish_ssh_agent
