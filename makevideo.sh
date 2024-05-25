#!/usr/bin/env bash
if [ "$(ls -A .)" ]; then
echo "Current directory has files, creating new directory \`dvbuild\` to keep $(pwd) clean"
mkdir dvbuild
fi
cd dvbuild

/usr/bin/env yt-dlp -f "bv*[ext=mp4][height<=1080]+ba[ext=m4a]/b[ext=mp4] / bv*[height<=1080]+ba/b" --split-chapters -o "chapter:%(section_number)s.%(ext)s" -P "vivaldi" "https://youtu.be/3LiztfE1X7E"
/usr/bin/env yt-dlp -f "bv*[ext=mp4][height<=1080]+ba[ext=m4a]/b[ext=mp4] / bv*[height<=1080]+ba/b"                  -o "film.%(ext)s"                            "https://vimeo.com/48858289"

/usr/bin/env ffmpeg \
  -i "film.mp4"\
  -stream_loop -1 -i "vivaldi/1.mp4"\
  -map 0:v:0 -map 1:a -map 0:a\
  -map_chapters -1\
  -c copy\
  -t "02:31:22"\
  -metadata:s:a:0 "title=Vivaldi: Spring"\
  -metadata:s:a:1 "title=Clicks (original)"\
  -metadata:s:a:0 "language="\
  "decodeunicode but vivaldi.mp4"