
echo 'Cleaning up "tmp/* and build/* folder....'
rm -rf tmp
rm -rf build

echo 'Creating empty build/blg_handbook/ folder...'
mkdir -p build/blg_handbook/www/

echo 'Copying all non-adoc files into content/images.... '
find ./content -type f \( -not -name "*.adoc" -and -not -name ".*" -and -not -name "CNAME" \) -exec cp -- "{}" tmp \;
cp tmp/* build/blg_handbook/www/
#find ./content/chapters appendix -type f \( -not -name "*.adoc" -and -not -name ".*" -and -not -name "CNAME" \) -exec cp -- "{}" content/images \;
#cp ./content/bigledger_logo.jpeg ./content/images
#cp ./content/akaun_colourful_logo.png ./content/images

echo 'Copying all non-adoc files into build/blg_handbook/www/images folder....'
#cp -r content/images/* build/blg_handbook/www/images
cp -r content/* tmp

echo 'Compiling Multipage HTML .....'
asciidoctor --trace -r asciidoctor-multipage -b multipage_html5 -o index.html -D build/blg_handbook/www tmp/index.adoc

echo 'Compiling single file.html....'
asciidoctor -o build/blg_handbook/www/blg_handbook.html tmp/index.adoc

echo 'Compiling DocBook format....'
asciidoctor -b docbook5 -o build/blg_handbook/www/blg_handbook.xml tmp/index.adoc

echo 'Compiling PDF Format....'
asciidoctor --trace -r asciidoctor-pdf -b pdf -o build/blg_handbook/www/blg_handbook.pdf tmp/index.adoc
# asciidoctor -a route-style=monokai --trace -r asciidoctor-pdf -b pdf -o build/all_in_one/all_in_one.pdf content/books/all_in_one/index.adoc

echo 'Compiling EPUB Format .....'
asciidoctor-epub3 -o build/blg_handbook/www/blg_handbook.epub tmp/index.adoc
# asciidoctor -r asciidoctor-epub3 -b epub3 -o docs/all_in_one.epub pub/all_in_one.adoc

#TIMESTAMP=tmp_$(date +"%Y-%m-%d-%H-%M")
#echo 'Copying files to docs folder for github pages publishing .... '
#mkdir -p docs/`date +"%Y-%m-%d-%H-%M"`
#mkdir -p docs/$TIMESTAMP
#cp -r build/blg_handbook/www/* docs/$TIMESTAMP
#cp ./build/blg_handbook/blg_handbook* docs/$TIMESTAMP
#cp ./content/CNAME docs/$TIMESTAMP

echo 'Opening docs folder...'
#git add .
#git commit -m "Compiled and commit .."
#open docs/$TIMESTAMP
open build/blg_handbook/www/index.html


