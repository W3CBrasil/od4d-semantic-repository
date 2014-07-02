#!/usr/bin/env bash

if [ "$OD4D_PROD_SERVER" == "" ]; then
	echo "Please set the server address using the environment variable OD4D_PROD_SERVER"
	exit 1
fi

CONNECTION_STRING=od4d@$OD4D_PROD_SERVER

scp tmp/fuseki-package.tar.gz $CONNECTION_STRING:~/
ssh $CONNECTION_STRING 'tar zxvf fuseki-package.tar.gz'
ssh $CONNECTION_STRING 'cd fuseki-config && ./deploy.sh'
ssh $CONNECTION_STRING 'rm fuseki-package.tar.gz && rm -r fuseki-config'