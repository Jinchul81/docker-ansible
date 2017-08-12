# docker-ansible

Dockerized Ansible commands

## Requirements

- Your SSH keys in place!
- Docker
- Make (on OSX you need Xcode developer tools to get this)

## Add aliases

For the Oh My Zsh shell:

```
$ make setup-zsh
```

For the default bash shell:

```
$ make setup-bash
```

You can also add aliases manually, see them below.

## Run commands

It's assumed you are using default Druid infra structure where:

- playbooks are in folder ./ansible
- inventory files are in folder ./ansible/inventory
- roles are in folder ./ansible/roles 

and that your keys are in:

- private key in ~/.ssh/id_rsa
- Vagrant insecure private key in ~/.vagrant.d/insecure_private_key

### Get version

```
$ docker run --rm -it druidfi/ansible ansible --version
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
