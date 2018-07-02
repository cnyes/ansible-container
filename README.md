# Ansible container for test kitchen docker driver.

## Purpose
1. speed up for test kitchen CI test.
2. provides unified ansible installation script for AWS SSM documents.

## Requirement
1. docker for mac

## Notes
1. if you update any scripts in ./scripts directory, please execute sync_scripts.sh to sync change files into dockerfiles directory for docker build context usage.
2. it will auto build with docker hub when pushed or merged. (https://hub.docker.com/r/anue/ansible-container/)
