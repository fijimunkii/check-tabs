#!/bin/bash

set -e
set -u
set -o pipefail

function finish {
  rm .tabs_introduced >/dev/null 2>&1
}
trap finish EXIT SIGHUP SIGINT SIGTERM

git diff -G $'\t' master...HEAD > .tabs_introduced && [ -s .tabs_introduced ] && echo "Error: Tabs introduced with this commit\n" && cat .tabs_introduced && exit 1
