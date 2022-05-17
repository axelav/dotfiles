function flac2m4a -d 'Convert flac files to m4a and remove originals'
  for file in *.flac
    echo "Processing $file"
    ffmpeg -i "$file" -y -v 0 -vcodec copy -acodec alac "$file".m4a
    echo "Success! $file.m4a"
  end
end
