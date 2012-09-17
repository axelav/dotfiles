cd ~/Library/Application Support/Sublime Text 2/Packages/User && git clone https://github.com/buymeasoda/soda-theme/ "Theme - Soda"

# the rest are stolen from Paul Irish: https://github.com/paulirish/dotfiles/blob/master/install-deps.sh

# https://github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
sudo bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)

# https://rvm.io
# rvm for the rubiess
curl -L https://get.rvm.io | bash -s stable --ruby

# homebrew!
# you need the code CLI tools YOU FOOL. (TODO: i wanna try kennethreitz's gcc osx installer isntead..)
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# install homebrew packages
./.brew

# compass
# http://compass-style.org/install/
gem install compass

# http://yeoman.io/
# yoeman
npm install -g yeoman

# https://github.com/rupa/z
# z, oh how i love you
mkdir -p ~/code/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
chmod +x ~/code/z/z.sh

# add this to the bash_profile file if it aint there.
#   . ~/code/z/z.sh
