#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

URL=http://localhost:3030/articles

./s-update --service http://localhost:3030/articles/update '
PREFIX schema: <http://schema.org/>
DELETE {?pub schema:name "Open Data for Development"}
INSERT {?pub schema:name "OD4D Platform"}
WHERE
{ 
	?pub a schema:Organization .
	?pub schema:name "Open Data for Development" .
}'

popd
