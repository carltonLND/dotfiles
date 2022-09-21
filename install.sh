for pkg in *; do
  if [[ -d $pkg ]]; then
    stow $pkg
  fi
done
