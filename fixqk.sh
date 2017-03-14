for line in $(find $1 -iname '*.html'); do 
   echo "$line"
   ls -l "$line"
	 tidy -e -utf8 -im -asxhtml -q "$line"

	 xsltproc --novalid --html --encoding UTF8 sanitize.xslt "$line" > "$line.out"
	 cp -f "$line.out" "$line"
	 rm "$line.out"
done


