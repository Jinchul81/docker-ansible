main() {

  # Repository
  REPO=https://github.com/druidfi/docker-ansible.git

  # Temporary clone path
  TMP_GIT_CLONE_PATH=/tmp/docker-ansible

  # Check that Docker is installed
  hash docker >/dev/null 2>&1 || {
    echo "Error: Docker is not installed. Get if from https://www.docker.com/get-docker"
    exit 1
  }

  # Check that git is installed
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }

  # Just to make sure, remove clone path
  rm -rf $TMP_GIT_CLONE_PATH

  # Clone the repository
  env git clone --depth=1 ${REPO} $TMP_GIT_CLONE_PATH || {
    printf "Error: git clone of druidfi/docker-ansible repo failed\n"
    exit 1
  }

  # Go to clone path and make install
  cd $TMP_GIT_CLONE_PATH
  make install
  rm -rf $TMP_GIT_CLONE_PATH

  echo ''
  echo 'You have now installed Dockerized Ansible!'
  echo ''
  echo 'Commands where installed to /usr/local/bin'
  echo ''
  echo 'Ansible commands available:'
  echo '- ansible'
  echo '- ansible-galaxy'
  echo '- ansible-playbook'
  echo ''
}

main
