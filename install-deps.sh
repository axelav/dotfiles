# install command line tools
xcode-select --install

# homebrew!
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# install homebrew packages
./.brew

# Sublime Text setup
# install Soda theme
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages && git clone https://github.com/buymeasoda/soda-theme/ "Theme - Soda"

# install Package Control
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages && curl -O "https://sublime.wbond.net/Package%20Control.sublime-package"

# set up preferences & install common packages
cp -r ~/Dropbox/projects/dotfiles/sublime/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/

# https://github.com/jamiew/git-friendly
sudo bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)

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

# remember to add this to the bash_profile file if it aint there.
#   . ~/code/z/z.sh
