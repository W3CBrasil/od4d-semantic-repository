#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

URL=http://localhost:3030/articles

./s-query --service $URL/query '
    PREFIX schema: <http://schema.org/>
    SELECT  ?partner ?description ?logo ?url ?name
    WHERE   { ?partner a schema:Organization .
            ?partner schema:description ?description .
            ?partner schema:logo ?logo .
            ?partner schema:url ?url .
            ?partner schema:name  ?name .
            }'

popd
