# vim: set ft=zsh:

# zsh prompt, with git prompt

bindkey -e

precmd ()
{
    build_prompt
}

build_prompt () {
    input_prompt=$'\n%(#.%B%F{red}.%F{magenta})>> %f%b'

    # If inside a git repository
    if $(git branch 1> /dev/null 2>&1); then
        repo_name=$(basename $(git rev-parse --show-toplevel))
        subpath=$(git rev-parse --show-prefix)
        branch=$(git rev-parse --abbrev-ref HEAD)
        # branch=$(echo $gsp | grep "##" | awk '{print $2}')

        # Only display a slash if we're actually in a subdirectory.
        [ -n "$subpath" ] && subpath="/$subpath"

        # Before pipe in prompt
        gsp=$(git status --porcelain --branch)
        git_tracked_new_files=$(echo $gsp | grep "^A " | wc -l | awk '{print $1}')
        git_modified_files=$(echo $gsp | grep "^ M" | wc -l | awk '{print $1}')
        git_deleted_files=$(echo $gsp | grep "^ D" | wc -l | awk '{print $1}')

        # After pipe in prompt
        git_untracked_new_files=$(echo $gsp | grep "^??" | wc -l | awk '{print $1}')
        git_assumed_unchanged=$(git ls-files -v | grep ^S | wc -l | awk '{print $1}')

        before_sum=$((git_tracked_new_files + git_modified_files + git_deleted_files))
        after_sum=$((git_untracked_new_files + git_assumed_unchanged))

        branch="%F{blue}$branch"

        preamble="%B%F{black}%f%b%F{yellow}$repo_name%f%B%F{black}$subpath ⋋ %b$branch %F{black}%B[%b%f "
        body=""
        postamble=" %F{black}%B]%b%f %1(j.%F{cyan}⎇  %j%f.)"

        if ((before_sum != 0)) then
            body="%b%F{green}+$git_tracked_new_files%f  %F{yellow}~$git_modified_files%f  %F{red}–$git_deleted_files%f"
        fi

        if ((after_sum != 0)) then
            if ((before_sum != 0)) then
                body="$body %F{black}%B|%b%f "
            fi
            body="$body%F{cyan}+$git_untracked_new_files%f  %F{blue}⊘$git_assumed_unchanged%f"
        fi

        PROMPT="$preamble$body$postamble$input_prompt"

    # Not in a git repository
    else
        PROMPT="%B%(#.%F{red}ROOT%f.%F{black}%n)%F{black} @ %m : %f%b%F{yellow}%d%f %1(j.%F{cyan}⎇  %j%f.)$input_prompt"
    fi
}

# Display the exit status of the last command as a green/red status light, and
# Print out the code if it's > 0.
RPROMPT="%(?.%F{green}.%F{red}%? )%{%G•%}%f"
