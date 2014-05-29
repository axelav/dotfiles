# install command line tools
xcode-select --install

# homebrew!
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# install homebrew packages
./.brew

# Sublime Text setup
# install Package Control
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages && curl -O "https://sublime.wbond.net/Package%20Control.sublime-package"

# install Vintageous
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages && curl -O "https://bitbucket.org/guillermooo/vintageous/downloads/Vintageous.sublime-package"

# set up preferences & install common packages
cp -r sublime/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/

# install npm globals
# npm install bower -g
npm i browserify -g
npm i coffee-script-redux -g
npm i express -g
npm i grunt-cli -g
npm i gulp
npm i jshint -g
npm i lute -g
npm i rainbowify -g
npm i spotify-cli -g
npm i trash -g


# https://github.com/rupa/z
mkdir -p ~/code/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
chmod +x ~/code/z/z.sh
