# docker-ansible

Dockerized Ansible commands.

This repo is automatically build to Docker Hub: https://hub.docker.com/r/druidfi/docker-ansible/

## Requirements

- Your SSH keys in place!
- Docker
- Make (on OSX you need Xcode developer tools to get this)

# Install

Installation will add scripts to run docker commands in /usr/local/bin.

Oneliner:

```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/druidfi/docker-ansible/master/install.sh)"
```

Or with the make after cloning this repo:

```
$ make install
```

## If you prefer aliases

Note: e.g. Vagrant will not know about your aliases!

For the Oh My Zsh shell:

```
$ make setup-zsh
```

For the default bash shell:

```
$ make setup-bash
```

You can also add aliases manually, see them below.

## Docker commands

It's assumed you are using default Druid infra structure where:

- playbooks are in folder ./ansible
- inventory files are in folder ./ansible/inventory
- roles are in folder ./ansible/roles 

and that your keys are in:

- private key in ~/.ssh/id_rsa
- Vagrant insecure private key in ~/.vagrant.d/insecure_private_key

### Get version

```
$ docker run --rm -it druidfi/docker-ansible ansible --version
```

### Install roles

```
$ docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(pwd):/ansible/playbooks druidfi/docker-ansible ansible-galaxy install -r ansible/requirements.yml -p ansible/roles
```

### Run playbook

```
$ docker run --rm -it -v $(pwd):/ansible/playbooks druidfi/docker-ansible ansible-playbook ansible/playbook.yml
```

## Aliasing

### ansible

```
$ alias ansible='docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(pwd):/ansible/playbooks druidfi/docker-ansible ansible'
```

### ansible-playbook

```
$ alias ansible-playbook='docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v ${HOME}/.vagrant.d/insecure_private_key:/root/.vagrant.d/insecure_private_key:ro -v $(pwd):/ansible/playbooks druidfi/docker-ansible ansible-playbook'
```

### ansible-galaxy

```
$ alias ansible-galaxy='docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(pwd):/ansible/playbooks druidfi/docker-ansible ansible-galaxy'
```

## Build the image

```
$ make build
```

or

```
$ docker build -t druidfi/ansible .
```

## Tested with

- macOS Sierra
- Ubuntu 16.04
