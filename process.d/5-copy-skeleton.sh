#!/bin/sh
set -e

mkdir -p repo
rsync -rt skeleton/ repo/
