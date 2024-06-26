# Decode Unicode, but with Vivaldi music
## What is this
While at the Deutsches Museum (German Museum) in Munich, I noticed that the first section of Antonio Vivaldi's Spring fit the Decode Unicode movie pretty well, so once I got home, I created a script that merges the movie and a performance of the piece (from YouTube) using `yt-dlp` and `ffmpeg`.

## How to use
### Dependencies
- `bash` (preinstalled on pretty much all GNU/Linux systems)
- `ffmpeg`
- `yt-dlp`

### Running
Once you have installed the dependencies, simply run the `makevideo.sh` script:
```
git clone https://github.com/libewa/decodevivaldi
cd decodevivaldi
./makevideo.sh
```
#### Nix
Nix users with flakes enabled can instead run one of these commands:
```
nix run github:libewa/decodevivaldi
nix shell github:libewa/decodevivaldi
nix profile install github:libewa/decodevivaldi
```
To install runtime dependencies for quick iteration, run this:
```
nix develop github:libewa/decodevivaldi
```