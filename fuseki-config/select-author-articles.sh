#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

URL=http://localhost:3030/articles

./s-query --service $URL/query '
PREFIX schema: <http://schema.org/>
SELECT  ?url ?headline ?datePublished ?author
WHERE   { ?article a schema:Article .
          OPTIONAL { ?article schema:url    ?url } .
          OPTIONAL { ?article schema:headline ?headline } .
          OPTIONAL { ?article schema:datePublished ?datePublished } .
          OPTIONAL { ?article schema:author ?author } .
          FILTER (?author = "author") .
        }
ORDER BY DESC(?datePublished)'

popd
