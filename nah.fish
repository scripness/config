function nah
    git reset --hard
    git clean -df
    
    if test -d ".git/rebase-apply" -o -d ".git/rebase-merge"
        git rebase --abort
    end
end
