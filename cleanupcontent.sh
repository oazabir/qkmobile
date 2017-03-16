FOLDER=./quranerkotha.com/
for line in $(find $FOLDER -iname '*.html'); do 
   echo "$line"
   ls -l "$line"
	 tidy -e -utf8 -im -asxhtml -q "$line"

	 xsltproc --novalid --html --encoding UTF8 sanitize.xslt "$line" > "$line.out"

   cmp --silent "$line" "$line.out" || cp -f "$line.out" "$line"
	 rm "$line.out"
done

find $FOLDER -name '*.html' -exec sed -i 's/<?xml version="4.0" encoding="UTF8"??>//' {} \;
