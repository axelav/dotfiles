function v -d 'Run neo/vim with an optional Session.vim if available'
  if hash nvim 2>/dev/null
    if [ $argv ]
      nvim $argv
    else if [ -f Session.vim ]
      nvim -S
    else
      nvim
    end
  else
    vim $argv
  end
end
