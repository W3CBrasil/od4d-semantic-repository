#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

URL=http://localhost:3030/articles

./s-update --service http://localhost:3030/articles/update '
PREFIX schema: <http://schema.org/>

DELETE
WHERE
{ 
  ?article schema:url <http://www.od4d.br/posts/37>; ?property ?value
}'

popd
