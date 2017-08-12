# docker-ansible

Dockerized Ansible commands

## Requirements

- Docker
- Make

## Build the image

```
$ make build
```

or

```
$ docker build -t druidfi/ansible .
```

## Publish to Docker Hub (needs login to druidfi account)

```
$ make push
```

## Add aliases (currently only to ~/.oh-my-zsh/custom/my.zsh)

```
$ make setup
```

You can also add aliases manually, see them below.

## Run commands

It's assumed you are using default Druid infra structure where:

- playbooks are in folder ./ansible
- inventory files are in folder ./ansible/inventory
- roles are in folder ./ansible/roles 

and that your keys are in:

- private key in ~/.ssh/id_rsa
- public key in ~/.ssh/id_rsa.pub

Get version

```
$ docker run --rm -it druidfi/ansible ansible --version
```

Install roles

```
$ docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(pwd):/ansible/playbooks druidfi/ansible ansible-galaxy install -r ansible/requirements.yml -p ansible/roles
```

Run playbook

```
$ docker run --rm -it -v $(pwd):/ansible/playbooks druidfi/ansible ansible-playbook ansible/playbook.yml
```

## Aliasing

ansible

```
$ alias ansible='docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(pwd):/ansible/playbooks druidfi/ansible ansible'
```

ansible-playbook

```
$ alias ansible-playbook='docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v ${HOME}/.vagrant.d/insecure_private_key:/root/.vagrant.d/insecure_private_key:ro -v $(pwd):/ansible/playbooks druidfi/ansible ansible-playbook'
```

ansible-galaxy

```
$ alias ansible-galaxy='docker run --rm -it -v ${HOME}/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(pwd):/ansible/playbooks druidfi/ansible ansible-galaxy'
```
