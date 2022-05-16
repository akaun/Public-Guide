echo 'Compiling build/all_in_one/single_file.html....'
asciidoctor -o docs/index.html all_in_one.adoc
asciidoctor -b docbook5 -o docs/all_in_one.xml all_in_one.adoc
asciidoctor -o docs/all_in_one-$(date +%Y-%m-%d).html all_in_one.adoc
asciidoctor -b docbook5 -o docs/all_in_one-$(date +%Y-%m-%d).xml all_in_one.adoc
asciidoctor -r asciidoctor-pdf -b pdf -o docs/all_in_one.pdf all_in_one.adoc
# asciidoctor -r asciidoctor-epub3 -b epub3 -o docs/all_in_one.epub all_in_one.adoc
# asciidoctor-epub3 -o docs/all_in_one.epub all_in_one.adoc
rm -rf docs/assets
cp -r ./assets docs