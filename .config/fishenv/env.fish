# fish load .env
function __fishenv_envsource
    for line in (cat $argv | grep -v '^#' | grep -v '^\s*$')
        set --local kv (string split -m 1 '=' $line)
        set --local k $kv[1]
        set --local v $kv[2]
        if [ "$$k" != $v ]
            set -gx $k $v
            echo "fishenv: set $k"
        end
    end
end

# run whenever you change directory
function __fishenv_hook --on-variable PWD
    # lazy load directory
    set --local envdir "$HOME/.config/fishenv"
    set --local rela (string replace "$HOME/" "" "$PWD")
    set --local pwdId (string replace --all "/" "-" "$rela")
    for file in (ls -a $envdir)
        # skip if not a .env file
        set --local abs "$envdir/$file"
        set --local ext (string sub --start=-4 -- $abs)
        if test ! -f "$abs" || [ (string sub --start=-4 -- $abs) != ".env" ]
            continue
        end
        set --local fileId (string sub --end=-4 -- $file)
        # pwdId will be something like "Code-Language-Project-Subdir-Maybe"
        # file will be something like "Code-Language-Project"
        switch $pwdId
            case "$fileId*"
                __fishenv_envsource "$abs"
        end
    end
end
__fishenv_hook
