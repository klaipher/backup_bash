#!/bin/zsh
while getopts ":i:o": flag; do
  case $flag in
  i) inputDir=${OPTARG} ;;
  o) outputDir=${OPTARG} ;;
  *)
    echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done



if [ ! -d "$inputDir" ] || [ ! -d "$outputDir" ]; then
  echo "Either input or output directory doesn't exist."
  exit 1
fi

outputPath="$outputDir/$(basename "$inputDir")-$(date +"%Y-%m-%d_%H:%M:%S").zip"

echo "Backing up $inputDir to $outputPath"

if [[ "$inputDir" == *".."* ]]; then
  echo "Please don't use '..' in input directory path."
  exit 1
fi

if ! command -v zip &>/dev/null; then
  echo "zip not found, please install zip..."
  exit 1
fi

zip -r "$outputPath" "$inputDir"
