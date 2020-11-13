# vim: set ft=zsh:

# zsh prompt, with git prompt

bindkey -e

precmd ()
{
    build_prompt
}

build_prompt () {
    # If inside a git repository
    if $(git branch 1> /dev/null 2>&1); then
        repo_name=$(basename $(git rev-parse --show-toplevel))
        branch=$(git rev-parse --abbrev-ref HEAD)
        subpath=$(git rev-parse --show-prefix)

        # Only display a slash if we're actually in a subdirectory.
        [ -n "$subpath" ] && subpath="/$subpath"

        git_untracked_new_files=$(git ls-files --others --exclude-standard | wc -w | tr -d ' \n')
        git_tracked_new_files=$(git diff-index --cached $branch | wc -l | tr -d ' \n')
        git_modified_files=$(git diff --name-only --diff-filter=M | wc -l | tr -d ' \n')
        git_deleted_files=$(git diff --name-only --diff-filter=D | wc -l | tr -d ' \n')

        branch="%F{blue}$branch"

        if [[ $git_tracked_new_files -eq 0 && $git_modified_files -eq 0 && git_deleted_files -eq 0 && $git_untracked_new_files -eq 0 ]] then
            PROMPT="%B%F{black}%f%b%F{red}$repo_name%f%B%F{black}$subpath ⋋ %b$branch%F{black} [  ] %1(j.%F{yellow}⎇  %j%f.)
%(#.%B%F{red}.%F{green})>> %f%b"
        elif [[ $git_tracked_new_files -eq 0 && $git_modified_files -eq 0 && git_deleted_files -eq 0 ]] then
            PROMPT="%B%F{black}%f%b%F{red}$repo_name%f%B%F{black}$subpath ⋋ %b$branch%F{black} [ %F{cyan}+$git_untracked_new_files%f %F{black}] %1(j.%F{yellow}⎇  %j%f.)
%(#.%B%F{red}.%F{green})>> %f%b"
        elif [[ $git_untracked_new_files -eq 0 ]] then
            PROMPT="%B%F{black}%f%b%F{red}$repo_name%f%B%F{black}$subpath ⋋ %b$branch%F{black} [ %b%F{green}+$git_tracked_new_files%f  %F{yellow}~$git_modified_files%f  %F{red}–$git_deleted_files%f %F{black}] %1(j.%F{yellow}⎇  %j%f.)
%(#.%B%F{red}.%F{green})>> %f%b"
        else
            PROMPT="%B%F{black}%f%b%F{red}$repo_name%f%B%F{black}$subpath ⋋ %b$branch%F{black} [ %b%F{green}+$git_tracked_new_files%f  %F{yellow}~$git_modified_files%f  %F{red}–$git_deleted_files%f | %F{cyan}+$git_untracked_new_files%f %F{black}] %1(j.%F{yellow}⎇  %j%f.)
%(#.%B%F{red}.%F{green})>> %f%b"
        fi

    # Not in a git repository
    else
        PROMPT="%B%(#.%F{red}ROOT%f.%F{black}%n)%F{black} @ %m : %f%b%F{red}%d%f %1(j.%F{yellow}⎇  %j%f.)
%(#.%B%F{red}.%F{green})>> %f%b"
    fi
}

# Display the exit status of the last command as a green/red status light, and
# Print out the code if it's > 0.
PROMPT="%(?.%F{green}.%F{red}%? )%{%G•%}%f"
