# homebrew!
# you need the code CLI tools YOU FOOL. (TODO: i wanna try kennethreitz's gcc osx installer isntead..)
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# install homebrew packages
./.brew

# Sublime Text 2 setup
# install Soda theme
cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages && git clone https://github.com/buymeasoda/soda-theme/ "Theme - Soda"

# install Package Control
# this doesn't work anymore cuz that file was moved
# cd ~/Library/Application\ Support/Sublime\ Text\ 2/Installed\ Packages && curl -O "http://sublime.wbond.net/Package Control.sublime-package"

# set up preferences & install common packages
cp -r ~/Dropbox/projects/dotfiles/sublime/* ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/

# the rest are stolen from Paul Irish: https://github.com/paulirish/dotfiles/blob/master/install-deps.sh

# https://github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
sudo bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)

# install npm globals
npm install grunt-cli -g
npm install nodemon -g
npm install bower -g
npm install browserify -g
npm install jshint -g

# compass
# http://compass-style.org/install/
gem install compass

# https://github.com/rupa/z
# z, oh how i love you
mkdir -p ~/code/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
chmod +x ~/code/z/z.sh

# add this to the bash_profile file if it aint there.
#   . ~/code/z/z.sh
