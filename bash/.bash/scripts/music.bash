# Size down album art and reduce its quality.
function resizeAlbumArt {
  convert -resize "1024x1024>" -quality 87 album.* _toUpload.jpg
  exit
}

function convertLoslessM4AtoFLAC {
  for file in *.m4a
    do
      ffmpeg -i "$file" -f flac "`basename "$file" .m4a`.flac"
    done
  rm -rf *.m4a
}

# Convert losless M4A to FLAC and then encode it to OGG.
function convertLoslessM4AtoOGG {
  convertLoslessM4AtoFLAC
  fastoggenc -q 9 -D -f *.flac
  addReplayGain
}

function convertMP3toOGG {
  fastoggenc -t -D -r -m . # quality of MP3, delete input, recursive, mp3
  addReplayGain
}

function convertM4AtoOGG {
  fastoggenc -q 8 -D -r -M . # quality 8, delete input, recursive, m4a
  addReplayGain
}

function convertFLACtoOGG {
  mv cover.jpg album.jpg
  fastoggenc -q 9 -D -r -f . # quality 9, delete input, recursive, flac
  addReplayGain
}

function extractBandcampAlbum {
  if [[ -z ${1} ]]; then
    exit -1
  fi

  archive="${1}"
  name=${archive%.zip}
  echo ${archive}
  echo ${name}

  unzip "${archive}"
  mv "${name}"/* .
  rm -r "${name}"
  rm "${archive}"

  convertFLACtoOGG
}

# Computes ReplayGain for either OGG, MP3 or FLAC files.
function addReplayGain {
  value=`find . -maxdepth 1 -iname "*.ogg" -type f | wc -l`
  if [[ $value > 0 ]]; then
    vorbisgain -a -f -r -s .
  else
    value=`find . -maxdepth 1 -iname "*.mp3" -type f | wc -l`
    if [[ $value > 0 ]]; then
      rename .MP3 .mp3 *.MP3 > /dev/null
      rename .Mp3 .mp3 *.Mp3 > /dev/null
      rename .mP3 .mp3 *.mP3 > /dev/null
      mp3gain -s i *.mp3
    else
      metaflac --add-replay-gain *.flac
    fi
  fi
  exit
}

# set permissions for music directory
# own to group audio and set rx for group
function reownMusicDir {
  cd $HOME
  echo "Setting 'audio' as group..."
  chgrp audio -R Music
  echo "Setting permissons for music directory..."
  chmod 4750 -R Music
  echo "Done."
  cd - >/dev/null
}
