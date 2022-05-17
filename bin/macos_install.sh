## Installing Homebrew - 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

## Refer to https://asciidoctor.cn/docs/install-toolchain/ 
sudo gem install asciidoctor
## Refer to https://docs.asciidoctor.org/asciidoctor/latest/install/macos/
# brew install asciidoctor

## Refer to https://docs.asciidoctor.org/epub3-converter/latest/ 
sudo NOKOGIRI_USE_SYSTEM_LIBRARIES=1 gem install asciidoctor-epub3
sudo gem install coderay



## https://asciidoctor.org/docs/asciidoctor-pdf/#install-the-published-gem
sudo gem install asciidoctor-pdf
sudo gem install rouge
sudo gem install pygments.rb
sudo gem install coderay

## Refer to https://github.com/owenh000/asciidoctor-multipage

sudo gem install asciidoctor-multipage
