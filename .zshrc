export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/opt/homebrew/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3.8
source /opt/homebrew/bin/virtualenvwrapper_lazy.sh
### fnm
eval "$(fnm env --use-on-cd)"
### alias
alias ll=ls -a

alias gocmp="cd ~/workspace/cmp-server"
alias gocl="cd ~/workspace/cmp-client"
alias goass="cd ~/workspace/assets"
alias gorepo="cd ~/workspace/content-repo"

alias pall='cd ~/workspace/ && find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} stash \; -exec git -C {} ch \; -exec git -C {} pull \;'
alias co="gh pr checkout -f"

alias ncd="nc-docker"
alias shell="ncd shell"
alias lg="ncd logs --no-log-prefix --tail 100 -f"
alias ncdu="ncd up"
alias ncdd="ncd down"

alias stc="ncdu cmp-client marketing-work-request aem-middleware episerver-middleware preview-url-cacher renditions-service"
cltest() {
  ncd exec cmp-client 'yarn test --nc-path="$1"'
}
stctest() {
  cltest structured-content 
}
rs() {
  ncd restart ${1} && lg ${1}
}
yarn() {
  if ! [ -x "$(command -v code-artifact-token-helper)" ]; then
    echo 'Error: localdev virtual env is not activated' >&2
    return 1
  fi
  code-artifact-token-helper
  export AWS_CODEARTIFACT_AUTH_TOKEN=$(cat ~/.nc_codeartifact_token)
  command yarn "$@"
}
workon localdev

# ~/.zshrc

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
