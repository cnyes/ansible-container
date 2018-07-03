#!/usr/bin/env bash

set -eo pipefail

function os_family_check {
    if [[ -f "/etc/system-release" ]]; then
        if grep -qi "Amazon Linux AMI release" "/etc/system-release"; then
            export OS_FAMILY="amazon1"
        elif grep -qi "VERSION_ID=\"2\"" "/etc/os-release"; then
            export OS_FAMILY="amazon2"
        fi
    elif [[ -f "/etc/os-release" ]]; then
        if grep -qi "Ubuntu 16.04" "/etc/os-release"; then
            export OS_FAMILY="ubuntu-1604"
        elif grep -qi "Ubuntu 18.04" "/etc/os-release"; then
            export OS_FAMILY="ubuntu-1804"
        fi
    fi
}

os_family_check

if [[ -z "${OS_FAMILY}" ]]; then
    echo "this os is not supported, exit."
    exit 1
fi

# install dependencies.
case "${OS_FAMILY}" in
    "amazon1")
        yum -y install python27-virtualenv
        ;;
    "amazon2")
        yum -y install python-virtualenv
        ;;
    "ubuntu-1604")
        apt-get update
        apt-get -y --no-install-recommends install python-pip
        pip --no-cache-dir install virtualenv==15.0.1
        ;;
    "ubuntu-1804")
        apt-get update
        apt-get -y --no-install-recommends install python-pip
        pip --no-cache-dir install virtualenv==15.1.0
        ;;
esac

export INSTALL_ANSIBLE_HOME=/opt/ansible
export INSTALL_ANSIBLE_VER="${INSTALL_ANSIBLE_VER:-2.6.0}"

virtualenv --python=python2.7 "${INSTALL_ANSIBLE_HOME}"
# shellcheck disable=SC1090
source "${INSTALL_ANSIBLE_HOME}/bin/activate"
pip install -U pip setuptools wheel
pip install ansible=="${INSTALL_ANSIBLE_VER}"

cd "${INSTALL_ANSIBLE_HOME}/bin" || exit 1
mapfile -t INSTALL_ANSIBLE_BIN_LIST < <(ls -d ansible*)

for exe_name in "${INSTALL_ANSIBLE_BIN_LIST[@]}"; do
    {
        echo '#!/usr/bin/env bash'
        echo "source ${INSTALL_ANSIBLE_HOME}/bin/activate"
        echo "${exe_name} \"\${@}\""
    } > "/usr/local/bin/${exe_name}"
    chmod +x "/usr/local/bin/${exe_name}"
done

exit 0
