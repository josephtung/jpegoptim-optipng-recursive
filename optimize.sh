#!/bin/bash

# Recursively resize images to a maximum width of 3000 px (keeping aspect ratio)
# then optimize JPEGs with jpegoptim and PNGs with optipng.
# Requires: ImageMagick (convert/mogrify), jpegoptim, optipng

shopt -s nullglob   # empty globs expand to nothing instead of the literal pattern

optimize() {
  # --- JPEGs ---
  for f in *.jpg *.jpeg *.JPG *.JPEG; do
    # Resize only if wider than 3000 px; height scales proportionally
    mogrify -resize '3000x>' "$f"
    jpegoptim --strip-all --all-progressive --max=90 "$f"
  done

  # --- PNGs ---
  for f in *.png *.PNG; do
    mogrify -resize '3000x>' "$f"
    optipng "$f"
  done

  # --- Recurse into subdirectories ---
  for i in *; do
    if [ -d "$i" ]; then
      (
        cd "$i" || exit 1
        echo "$i"
        optimize
      )
    fi
  done
  echo
}

optimize
