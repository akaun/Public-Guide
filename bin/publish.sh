echo 'Removing build/all_in_one/ folder...'
rm -rf build/all_in_one
echo 'Creating empty build/all_in_one/ folder...'
mkdir -p build/all_in_one/www

echo 'Compiling single file.html....'
# asciidoctor -o docs/index.html content/all_in_one.adoc
asciidoctor -o build/all_in_one/all_in_one.html content/index.adoc

echo 'Compiling DocBook format....'
asciidoctor -b docbook5 -o build/all_in_one/all_in_one.xml content/index.adoc

echo 'Compiling PDF Format....'
asciidoctor --trace -r asciidoctor-pdf -b pdf -o build/all_in_one/all_in_one.pdf content/index.adoc
# asciidoctor -a route-style=monokai --trace -r asciidoctor-pdf -b pdf -o build/all_in_one/all_in_one.pdf content/books/all_in_one/index.adoc

echo 'Compiling EPUB Format .....'
asciidoctor-epub3 -o build/all_in_one/all_in_one.epub content/index.adoc
# asciidoctor -r asciidoctor-epub3 -b epub3 -o docs/all_in_one.epub pub/all_in_one.adoc

echo 'Compiling Multipage HTML .....'
asciidoctor --trace -r asciidoctor-multipage -b multipage_html5 -o index.html -D build/all_in_one/www content/index.adoc
cp -r content/books/all_in_one/assets build/all_in_one/www

echo 'Cleaning up "docs/* folder....'
rm -rf docs/*
echo 'Copying files to docs folder for github pages publishing .... '
cp -r build/all_in_one/www/* docs
cp -r content/assets  build/all_in_one/www
cp -r content/assets  docs
cp ./build/all_in_one/all_in_one* docs
cp ./content/CNAME docs

echo 'Pushing to github...'
git add .
git commit -m "Compiled and commit .."
git push
open docs
