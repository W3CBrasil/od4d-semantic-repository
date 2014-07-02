#!/usr/bin/env bash

OUTPUT_FOLDER="./output"

[ ! -e "$OUTPUT_FOLDER" ] && mkdir $OUTPUT_FOLDER

tar cz -f $OUTPUT_FOLDER/fuseki-package.tar.gz fuseki-config
cp deploy.sh $OUTPUT_FOLDER/deploy.sh
