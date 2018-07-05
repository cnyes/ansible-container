FROM ubuntu:18.04
COPY ./scripts/ansible_install.sh /tmp
RUN export APT_INSTALL="apt-get --no-install-recommends -y install" && \
    bash /tmp/ansible_install.sh && \
    ${APT_INSTALL} sudo openssh-server curl lsb-release && \
    mkdir -p /run/sshd && \
    apt-get clean all && \
    rm -rf /tmp/* /var/tmp/*
