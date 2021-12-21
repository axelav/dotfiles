function v -d 'Run neo/vim with an optional Session.vim if available'
  if hash nvim 2>/dev/null
    if test "$argv"
      nvim $argv
    else if test -f Session.vim
      nvim -S
    else
      nvim
    end
  else
    vim $argv
  end
end
