# ensure dependencies are installed
if ! [ -x "$(command -v exiftool)" ]; then
    echo 'Error: exiftool is not installed.' >&2
    exit 1
fi

srcFolder=$(dirname "$1")

# get some needed information out of EXIF data of media file
createTimestamp=$(exiftool "$1" -s -s -s -EXIF:CreateDate -dateFormat %Y%m%d_%H%M%S)
modifyTimestamp=$(exiftool "$1" -s -s -s -filemodifydate -dateFormat %Y%m%d_%H%M%S)
camera=$(exiftool "$1" -s -s -s -EXIF:Model | tr -d '" ' | tr "[:upper:]" "[:lower:]")
creator=$(exiftool "$1" -s -s -s -EXIF:Software | tr -d '" .' | tr "[:upper:]" "[:lower:]")

# fallback to modify time is not a good idea because it will change when
# someone else is copying a file to for example another directory.
# or even adding the files to github like for our unit tests will change the date
# every photo should just have createTimestamp and otherwise we should ignore it
timestamp="${createTimestamp:-$modifyTimestamp}"
createdBy="${camera:-$creator}"

# get extension using output from 'file' command which
# also makes it possible to handle files without extension
fullFilename=$(exiftool "$1" -s -s -s -filetypeextension)
extension=$(echo "${fullFilename##*.}" | tr "[:upper:]" "[:lower:]")

if [[ $extension != "nef" && $extension != "jpg" && $extension != "jpeg" && $extension != "tif" && $extension != "mov" && $extension != "mp4" && $extension != "png" ]]; then
    echo "[skip] unsupported file format ${extension} passed" 
    exit
fi

# generate a hash which function as a unique string for the
# media file that gets passed
hash=$(shasum "$1" | cut -d " " -f1)
shortHash=$(echo $hash | cut -c1-7)

# copy media file over to it's new home using it's new name
echo "${timestamp}_${createdBy:-unkown}_${shortHash}.${extension}"
