main() {

  TMP_GIT_CLONE_PATH=/tmp/docker-ansible
  ZSH=~/.oh-my-zsh

  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }

  env git clone --depth=1 https://github.com/druidfi/docker-ansible.git $TMP_GIT_CLONE_PATH || {
    printf "Error: git clone of druidfi/docker-ansible repo failed\n"
    exit 1
  }

  make -f $TMP_GIT_CLONE_PATH/Makefile install && rm -rf $TMP_GIT_CLONE_PATH
}

main
