path=$HOME/.fzf.bash

if [ -f "${path}" ]; then
  source "${path}"
  sourceScript "fzf-git"

  export FZF_DEFAULT_COMMAND='ag -l -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  # export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

  # Use ag instead of the default find command for listing candidates.
  # - The first argument to the function is the base path to start traversal
  # - Note that ag only lists files not directories
  # - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_path() {
    ag -g "" "$1"
  }

  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
  # Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)

  # fda - including hidden directories
  fda() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
  }

  # fe [FUZZY PATTERN] - Open the selected file with the default editor
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
  fe() {
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  }

  # cdf - cd into the directory of the selected file
  cdf() {
     local file
     local dir
     file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
  }
fi
