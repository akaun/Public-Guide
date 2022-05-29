
echo 'Cleaning up "docs/* folder....'
rm -rf docs
rm -rf content/assets
rm -rf build/blg_handbook

echo 'Creating empty build/blg_handbook/ folder...'
mkdir -p build/blg_handbook/www/assets
mkdir -p content/assets
mkdir -p docs

echo 'Copying all non-adoc files into content/assets.... '
find ./content/modules -type f \( -not -name "*.adoc" -and -not -name ".*" -and -not -name "CNAME" \) -exec cp -- "{}" content/assets \;
#find ./content/modules appendix -type f \( -not -name "*.adoc" -and -not -name ".*" -and -not -name "CNAME" \) -exec cp -- "{}" content/assets \;
cp ./content/bigledger_logo.jpeg ./content/assets
cp ./content/akaun_colourful_logo.png ./content/assets

echo 'Copying all non-adoc files into build/blg_handbook/www/assets folder....'
cp -r content/assets/* build/blg_handbook/www/assets


echo 'Compiling Multipage HTML .....'
asciidoctor --trace -r asciidoctor-multipage -b multipage_html5 -o index.html -D build/blg_handbook/www content/index.adoc

echo 'Compiling single file.html....'
asciidoctor -o build/blg_handbook/www/blg_handbook.html content/index.adoc

echo 'Compiling DocBook format....'
asciidoctor -b docbook5 -o build/blg_handbook/www/blg_handbook.xml content/index.adoc

echo 'Compiling PDF Format....'
asciidoctor --trace -r asciidoctor-pdf -b pdf -o build/blg_handbook/www/blg_handbook.pdf content/index.adoc
# asciidoctor -a route-style=monokai --trace -r asciidoctor-pdf -b pdf -o build/all_in_one/all_in_one.pdf content/books/all_in_one/index.adoc

echo 'Compiling EPUB Format .....'
asciidoctor-epub3 -o build/blg_handbook/www/blg_handbook.epub content/index.adoc
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


