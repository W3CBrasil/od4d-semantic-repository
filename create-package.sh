#!/usr/bin/env bash

[ ! -e "./tmp" ] && mkdir ./tmp
tar cz -f ./tmp/fuseki-package.tar.gz fuseki-config