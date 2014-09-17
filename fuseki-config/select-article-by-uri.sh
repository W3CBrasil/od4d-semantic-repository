#!/usr/bin/env bash

pushd "/opt/od4d/fuseki"

URL=http://localhost:3030/articles

./s-query --service $URL/query '
PREFIX schema: <http://schema.org/>
SELECT  ?article ?url ?author ?headline ?summary ?description ?articleBody ?articleSection ?datePublished ?publisher
WHERE   { ?article a schema:Article .
          OPTIONAL { ?article schema:url    ?url } .
          OPTIONAL { ?article schema:author ?author } .
          OPTIONAL { ?article schema:headline ?headline } .
          OPTIONAL { ?article schema:summary  ?summary } .
          OPTIONAL { ?article schema:description ?description } .
          OPTIONAL { ?article schema:articleBody ?articleBody } .
          OPTIONAL { ?article schema:articleSection ?articleSection } .
          OPTIONAL { ?article schema:datePublished ?datePublished } .
          OPTIONAL { ?article schema:publisher ?publisher } .
          FILTER (?url = <http://opendataresearch.org/events/berlin2014/webcast>) .
        } LIMIT 1'

popd


