_gitme_complete() {
  local cur prev words cword
  _init_completion || return

  local GITME_CACHE_DIR="${GITME_CACHE_DIR:-$HOME/.gitme}"
  local GITME_CACHE_FILE="$GITME_CACHE_DIR/cache"

  local candidates=()

  # Use cache if it exists and is not empty, otherwise fall back to scanning
  if [[ -s "$GITME_CACHE_FILE" ]]; then
    while IFS=$'\t' read -r dir remote_url; do
      [[ -z "$dir" ]] && continue
      repo_name="$(basename "$dir")"
      candidates+=("$repo_name" "$remote_url")
    done < "$GITME_CACHE_FILE"
  else
    local GITME_DIRS="${GITME_DIRS:-$HOME/git}"
    IFS=':' read -ra DIRS <<< "$GITME_DIRS"

    for base in "${DIRS[@]}"; do
      [[ -d "$base" ]] || continue
      while IFS= read -r dir; do
        repo_name="$(basename "$dir")"
        remote_url="$(git -C "$dir" config --get remote.origin.url 2>/dev/null || echo "")"
        candidates+=("$repo_name" "$remote_url")
      done < <(find "$base" -type d -name .git -exec dirname {} \;)
    done
  fi

  COMPREPLY=($(compgen -W "${candidates[*]}" -- "$cur"))
}

complete -F _gitme_complete gitme

