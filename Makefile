MAKEFLAGS += --silent

SHELL_FILE=${HOME}/.oh-my-zsh/custom/my.zsh

ALIAS_ANSIBLE=alias ansible='docker run --rm -it -v "\$${HOME}"/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v "\$$"(pwd):/ansible/playbooks druidfi/ansible ansible'
ALIAS_ANSIBLE_PLAYBOOK=alias ansible-playbook='docker run --rm -it -v "\$${HOME}"/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v "\$${HOME}"/.vagrant.d/insecure_private_key:/root/.vagrant.d/insecure_private_key:ro -v "\$$"(pwd):/ansible/playbooks druidfi/ansible ansible-playbook'
ALIAS_ANSIBLE_GALAXY=alias ansible-galaxy='docker run --rm -it -v "\$${HOME}"/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v "\$$"(pwd):/ansible/playbooks druidfi/ansible ansible-galaxy'

build:
	docker build -t druidfi/ansible .

push:
	docker build --no-cache -t druidfi/ansible .
	docker push druidfi/ansible

setup:
	grep -q "${ALIAS_ANSIBLE}" "${SHELL_FILE}" || echo "${ALIAS_ANSIBLE}" >> "${SHELL_FILE}"
	grep -q "${ALIAS_ANSIBLE_PLAYBOOK}" "${SHELL_FILE}" || echo "${ALIAS_ANSIBLE_PLAYBOOK}" >> "${SHELL_FILE}"
	grep -q "${ALIAS_ANSIBLE_GALAXY}" "${SHELL_FILE}" || echo "${ALIAS_ANSIBLE_GALAXY}" >> "${SHELL_FILE}"
