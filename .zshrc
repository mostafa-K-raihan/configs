# flutter 
export PATH="$PATH:$HOME/mobile-dev/flutter/flutter/bin"

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
alias so="source ~/.zshrc"
activate() {
  if [ -z "$VIRTUAL_ENV" ]; then
    workon localdev
  fi
}

activate

bindkey -v
alias gocmp="cd ~/workspace/cmp-server"
alias gocl="cd ~/workspace/cmp-client"
alias goassets="cd ~/workspace/assets"
alias gorepo="cd ~/workspace/content-repo"
alias golocal="cd ~/workspace/localdev"
alias gopal="cd ~/workspace/opal-copilot-frontend"
alias goaxiom="cd ~/workspace/optiaxiom"
alias goproject="cd ~/projects/"

alias so="source ~/.zshrc"
alias g="git"
alias y="yarn"

alias pall='cd ~/workspace/ && find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} stash \; -exec git -C {} ch \; -exec git -C {} pull \;'
alias co="gh pr checkout -f"

alias ncd="nc-docker"
alias shell="ncd shell"
alias lg="ncd logs --no-log-prefix --tail 100 -f"
alias ncdu="ncd up"
alias ncdd="ncd down"

alias stc="ncdu cmp-client marketing-work-request aem-middleware episerver-middleware preview-url-cacher renditions-service"
alias repo_hook="docker exec content-repo make lint format-diff typecheck-only test-only"
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

alias USER_ID='65b0d94190391502972ad7ea'
alias ORG_ID='5d75b97d4886f3796653409e'
#
## Create a stable channel PR from edge channel PR
#
#    git-stable-pr 1234 some-name
#
# 1: the PR number in edge channel
# 2: label used to name new branch
git-stable-pr() {
  git remote get-url edge 2>/dev/null || git remote add edge git@github.com:newscred/cmp-client.git
  git fetch edge master

  git remote get-url stable 2>/dev/null || git remote add stable git@github.com:newscred/cmp-client-stable.git
  git fetch stable master

  BR=$(printf -- "-%s" "$@" | awk '{print substr($1, 2)}')
  git fetch edge pull/$1/head:pr/$BR
  git co pr/$BR

  git rebase --onto stable/master $(git merge-base HEAD edge/master) pr/$BR
}
# workon localdev
alias jumpbox="ssh mostafa.raihan@172.27.27.238"
# ~/.zshrc



eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -Uz compinit && compinit
# terminal name
precmd () {print -Pn "\e]0;%~\a"}

# Created by `pipx` on 2024-02-08 07:18:01
export PATH="$PATH:/Users/mostafa.raihan/.local/bin"

