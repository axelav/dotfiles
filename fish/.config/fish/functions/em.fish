function em -d 'Run Emacs'
  if test (count $argv) -eq 0
    echo "Starting new Emacs process ..." >&2
    emacs
  else if emacsclient -n $argv 2> /dev/null
    echo "Opened $argv in Emacs server" >&2
  else
    echo "Opening $argv in a new Emacs process ..." >&2
    emacs $argv
  end
end
