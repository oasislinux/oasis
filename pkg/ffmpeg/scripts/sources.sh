#!/bin/sh

set -ex

../src/configure >/dev/null
awk '{print $2}' config.asm >vars.txt
make -f sources.mk >../sources.txt
git clean -df .
