#!/bin/bash

# Downscales the image given to 4k

# all stderr from imagemagick were streamed to /dev/null
# as Galaxy S* creates flawed jpegs

function downscale {

  image="$1"

  type=$(magick identify -format '%m' "$image" 2> /dev/null)
  retVal=$?
  if [ $retVal -ne 0 ] || ([ "$type" != 'JPEG' ] && [ "$type" != 'PNG' ]); then
    echo "Unsupported image type for $image"
    return
  fi

  width=$(magick identify -format '%w' "$image" 2> /dev/null)
  height=$(magick identify -format '%h' "$image" 2> /dev/null)

  if [ $width -le 4096 ] || [ $height -le 2160 ]; then
    echo "Already lower than 4k - $image";
    return
  fi

  if [ $width -gt $height ]; then
    convert "$image" -resize 4096 "$image" 2> /dev/null
  else
    convert "$image" -resize x2160 "$image" 2> /dev/null
  fi

  new_width=$(magick identify -format '%w' "$image")
  new_height=$(magick identify -format '%h' "$image")

  echo "$image scaled from ${width}x${height} to ${new_width}x${new_height}"
}

for file in "$@"
do
  fileending="${file##*.}"
  fileending="${fileending,,}" # to lowercase
  if [ "$fileending" == 'jpg' ] || \
     [ "$fileending" == 'jpeg' ] || \
     [ "$fileending" == 'png' ]; then
       downscale "$file"
  else
    echo "Unsupported file type $fileending"
  fi
done
