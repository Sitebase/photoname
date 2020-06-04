srcFolder=$(dirname "$1")

# get some needed information out of EXIF data of media file
timestamp=$(mdls "$1" | grep "kMDItemContentCreationDate " | cut -d "=" -f2 | cut -d " " -f2,3 | sed 's/-//g' | sed 's/://g' | sed 's/ /_/g')
camera=$(mdls "$1" | grep 'kMDItemAcquisitionModel' | cut -d "=" -f2 | tr -d '" ' | tr "[:upper:]" "[:lower:]")
creator=$(mdls "$1" | grep 'kMDItemCreator' | cut -d "=" -f2 | tr -d '" .' | tr "[:upper:]" "[:lower:]")
createdBy="${camera:-$creator}"

# get extension using output from 'file' command which
# also makes it possible to handle files without extension
fullFilename=$(file "$1" | cut -d ":" -f1)
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
