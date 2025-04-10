_gitme_complete() {
  local cur prev words cword
  _init_completion || return

  local GITME_DIRS="${GITME_DIRS:-$HOME/git}"
  IFS=':' read -ra DIRS <<< "$GITME_DIRS"

  local candidates=()

  for base in "${DIRS[@]}"; do
    [[ -d "$base" ]] || continue
    while IFS= read -r dir; do
      repo_name="$(basename "$dir")"
      remote_url="$(git -C "$dir" config --get remote.origin.url 2>/dev/null || echo "")"
      candidates+=("$repo_name" "$remote_url")
    done < <(find "$base" -type d -name .git -exec dirname {} \;)
  done

  COMPREPLY=($(compgen -W "${candidates[*]}" -- "$cur"))
}

complete -F _gitme_complete gitme

