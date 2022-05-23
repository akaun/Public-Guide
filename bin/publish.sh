
echo 'Cleaning up "docs/* folder....'
rm -rf docs/*
rm -rf content/assets
rm -rf build/blg_blueprint

echo 'Creating empty build/blg_blueprint/ folder...'
mkdir -p build/blg_blueprint/www/assets
mkdir -p content/assets

echo 'Copying all non-adoc files into content/assets.... '
find ./content/chapters -type f \( -not -name "*.adoc" -and -not -name ".*" -and -not -name "CNAME" \) -exec cp -- "{}" content/assets \;
find ./content/other -type f \( -not -name "*.adoc" -and -not -name ".*" -and -not -name "CNAME" \) -exec cp -- "{}" content/assets \;
cp ./content/bigledger_logo.jpeg ./content/assets

echo 'Copying all non-adoc files into build/blg_blueprint/www/assets folder....'
cp -r content/assets/* build/blg_blueprint/www/assets

echo 'Compiling single file.html....'
asciidoctor -o build/blg_blueprint/blg_blueprint.html content/index.adoc

echo 'Compiling DocBook format....'
asciidoctor -b docbook5 -o build/blg_blueprint/blg_blueprint.xml content/index.adoc

echo 'Compiling PDF Format....'
asciidoctor --trace -r asciidoctor-pdf -b pdf -o build/blg_blueprint/blg_blueprint.pdf content/index.adoc
# asciidoctor -a route-style=monokai --trace -r asciidoctor-pdf -b pdf -o build/all_in_one/all_in_one.pdf content/books/all_in_one/index.adoc

echo 'Compiling EPUB Format .....'
asciidoctor-epub3 -o build/blg_blueprint/blg_blueprint.epub content/index.adoc
# asciidoctor -r asciidoctor-epub3 -b epub3 -o docs/all_in_one.epub pub/all_in_one.adoc

echo 'Compiling Multipage HTML .....'
asciidoctor --trace -r asciidoctor-multipage -b multipage_html5 -o index.html -D build/blg_blueprint/www content/index.adoc


echo 'Copying files to docs folder for github pages publishing .... '
cp -r build/blg_blueprint/www/* docs
cp ./build/blg_blueprint/blg_blueprint* docs
cp ./content/CNAME docs

echo 'Pushing to github...'
#git add .
#git commit -m "Compiled and commit .."
open docs
