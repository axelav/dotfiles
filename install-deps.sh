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
npm install bower -g
npm install browserify -g
# npm install coffee-script -g
npm install coffee-script-redux -g
npm install express -g
npm install grunt-cli -g
npm install jshint -g
npm install lute -g
npm install spotify-cli -g


# https://github.com/rupa/z
mkdir -p ~/code/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
chmod +x ~/code/z/z.sh
