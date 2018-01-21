#!/bin/bash

for file in "$@"; do
  exiftool -P '-filename<CreateDate' -d %Y-%m-%d_%H%M%S%%-c.%%le -r -ext jpg -ext orf -ext nef -ext mp4 "$file"
done
