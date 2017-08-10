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

and that your keys are in:

- private key in ~/.ssh/id_rsa
- public key in ~/.ssh/id_rsa.pub

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

Provisioning example on Vagrant using ~/.vagrant.d/insecure_private_key

```
$ docker run --rm -it -v ~/.vagrant.d/insecure_private_key:/root/.vagrant.d/insecure_private_key -v $(pwd):/ansible/playbooks druidfi/ansible ansible-playbook -i ansible/inventory/development ansible/provision.yml
```

## Aliasing

```
$ alias ansible-galaxy="docker run --rm -it -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v $(pwd):/ansible/playbooks druidfi/ansible ansible-galaxy"
```
