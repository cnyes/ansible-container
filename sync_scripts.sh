#!/usr/bin/env bash

for dir in dockerfiles/*; do
    cp -rp ./scripts "$dir/"
done
