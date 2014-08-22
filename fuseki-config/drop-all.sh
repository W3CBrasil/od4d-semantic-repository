#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

./s-update --service http://localhost:3030/articles/update 'CLEAR DEFAULT'

popd
