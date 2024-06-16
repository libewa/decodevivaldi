#!/usr/bin/env bash
set -e

WORKDIR=$(pwd)
TEMPDIR=$(mktemp --directory)
echo "Working in $TEMPDIR, outputting to $WORKDIR"
cd $TEMPDIR

echo "== Downloading music =="
/usr/bin/env yt-dlp -f "ba[ext=mp4]" --split-chapters -o "chapter:%(section_number)s.%(ext)s" -P "vivaldi" "https://youtu.be/3LiztfE1X7E"
mv vivaldi/1.mp4 .
rm -rf vivaldi
echo "== Downloading video =="
/usr/bin/env yt-dlp -f "bv*[ext=mp4][height<=1080]+ba[ext=m4a]/b[ext=mp4] / bv*[height<=1080]+ba/b"                  -o "film.%(ext)s"                            "https://vimeo.com/48858289"

echo "== Merging files =="
/usr/bin/env ffmpeg \
  -i "film.mp4"\
  -stream_loop -1 -i "1.mp4"\
  -map 0:v:0 -map 1:a -map 0:a\
  -map_chapters -1\
  -c copy\
  -t "02:31:22"\
  -metadata:s:a:0 "title=Vivaldi: Spring"\
  -metadata:s:a:1 "title=Clicks (original)"\
  -metadata:s:a:0 "language="\
  "decodeunicode but vivaldi.mp4"

echo "== Moving result to shell working directory =="
mv -iv "decodeunicode but vivaldi.mp4" $WORKDIR