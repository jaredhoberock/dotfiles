eval $(/opt/homebrew/bin/brew shellenv)

case `uname` in
  *Darwin*) STARSHIP_OS="";;
  *Linux*)  STARSHIP_OS="";;
  *)        STARSHIP_OS="";;
esac

export STARSHIP_OS

export STARSHIP_CONFIG=~/dev/git/dotfiles/.config/starship.toml
eval "$(starship init zsh)"
