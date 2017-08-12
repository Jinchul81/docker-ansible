FROM alpine:latest

MAINTAINER Marko Korhonen <marko.korhonen@druid.fi>

RUN apk --update add sudo
RUN apk add --no-cache bash git openssh
RUN apk --update add python py-pip openssl ca-certificates
RUN apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base
RUN pip install --upgrade pip cffi
RUN pip install ansible
RUN apk --update add sshpass openssh-client rsync
RUN apk del build-dependencies
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /etc/ansible
RUN echo 'localhost' > /etc/ansible/hosts
RUN mkdir -p /root/.ssh
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN mkdir -p /ansible/playbooks

WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
