#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

./s-update --service http://localhost:3030/articles/update '
PREFIX schema: <http://schema.org/>
INSERT {?pub schema:inLanguage "en"}
WHERE
{ 
	?pub a schema:Article .
}'

popd
