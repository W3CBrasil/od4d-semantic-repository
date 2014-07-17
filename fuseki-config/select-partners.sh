#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

URL=http://localhost:3030/articles

./s-query --service $URL/query '
PREFIX schema: <http://schema.org/>
SELECT  ?s ?p ?o
WHERE   { ?s a schema:Organization .
          ?s ?p ?o
        }
'

popd
