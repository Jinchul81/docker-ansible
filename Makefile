MAKEFLAGS += --silent

DOCKER_IMAGE=druidfi/ansible
ALIAS_ANSIBLE=alias ansible='docker run --rm -it -v "\$${HOME}"/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v "\$$"(pwd):/ansible/playbooks ${DOCKER_IMAGE} ansible'
ALIAS_ANSIBLE_PLAYBOOK=alias ansible-playbook='docker run --rm -it -v "\$${HOME}"/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v "\$${HOME}"/.vagrant.d/insecure_private_key:/root/.vagrant.d/insecure_private_key:ro -v "\$$"(pwd):/ansible/playbooks ${DOCKER_IMAGE} ansible-playbook'
ALIAS_ANSIBLE_GALAXY=alias ansible-galaxy='docker run --rm -it -v "\$${HOME}"/.ssh/id_rsa:/root/.ssh/id_rsa:ro -v "\$$"(pwd):/ansible/playbooks ${DOCKER_IMAGE} ansible-galaxy'

build:
	docker build -t ${DOCKER_IMAGE} .

push:
	docker build --no-cache -t ${DOCKER_IMAGE} .
	docker push ${DOCKER_IMAGE}

setup-bash: SHELL_FILE=${HOME}/.bash_profile
setup-bash:
	touch ${HOME}/.bash_profile || exit
setup-bash: create-aliases

setup-zsh: SHELL_FILE=${HOME}/.oh-my-zsh/custom/my.zsh
setup-zsh:
	touch ${HOME}/.oh-my-zsh/custom/my.zsh || exit
setup-zsh: create-aliases

create-aliases:
	echo "Create aliases to ${SHELL_FILE}"
	grep -q "${ALIAS_ANSIBLE}" "${SHELL_FILE}" || echo "${ALIAS_ANSIBLE}" >> "${SHELL_FILE}"
	grep -q "${ALIAS_ANSIBLE_PLAYBOOK}" "${SHELL_FILE}" || echo "${ALIAS_ANSIBLE_PLAYBOOK}" >> "${SHELL_FILE}"
	grep -q "${ALIAS_ANSIBLE_GALAXY}" "${SHELL_FILE}" || echo "${ALIAS_ANSIBLE_GALAXY}" >> "${SHELL_FILE}"
