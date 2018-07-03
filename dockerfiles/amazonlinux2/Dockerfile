FROM amazonlinux:2
ARG ANSIBLE_INSTALL_URL=https://bitbucket.org/protosschris/ansible-container/raw/master/scripts/ansible_install.sh
COPY ./scripts/ansible_install.sh /tmp
RUN bash /tmp/ansible_install.sh && \
    yum -y install sudo openssh-server openssh-clients curl which && \
    yum clean all && \
    rm -rf /tmp/*
