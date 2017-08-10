# docker-ansible

Dockerized Ansible commands

## Requirements

- Docker

## Build the image

```
$ docker build -t druidfi/ansible .
```

## Run commands

It's assumed you are using default Druid infra structure where:

- playbooks are in folder ./ansible
- inventory files are in folder ./ansible/inventory
- roles are in folder ./ansible/roles 

Get version

```
$ docker run --rm -it druidfi/ansible ansible-playbook --version
```

Install roles

```
$ docker run --rm -it -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v $(pwd):/ansible/playbooks druidfi/ansible ansible-galaxy install -r ansible/requirements.yml -p ansible/roles
```

Run playbook

```
$ docker run --rm -it -v $(pwd):/ansible/playbooks druidfi/ansible ansible-playbook ansible/playbook.yml
```

## Aliasing

```
$ alias ansible-galaxy="docker run --rm -it -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v $(pwd):/ansible/playbooks druidfi/ansible ansible-galaxy"
```