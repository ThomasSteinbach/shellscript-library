#!/bin/bash

exiftool -P '-filename<CreateDate' -d %Y-%m-%d_%H%M%S%%-c.%%le -r -ext jpg -ext orf -ext nef -ext mp4 -ext m4v .
