#!/usr/bin/env bash

if [ "$OD4D_PROD_SERVER" == "" ]; then
	echo "Please set the server address using the environment variable OD4D_PROD_SERVER"
	exit 1
fi

CONNECTION_STRING=od4d@$OD4D_PROD_SERVER
PACKAGE_FILE=fuseki-package.tar.gz

if [ ! -f "$PACKAGE_FILE" ]; then
	echo "File $PACKAGE_FILE not found."
	echo "Please call this is script from the same directory where the $PACKAGE_FILE is locate."
fi 

scp $PACKAGE_FILE $CONNECTION_STRING:~/
ssh $CONNECTION_STRING 'tar zxvf fuseki-package.tar.gz'
ssh $CONNECTION_STRING 'cd fuseki-config && ./install.sh'
ssh $CONNECTION_STRING 'rm fuseki-package.tar.gz && rm -r fuseki-config'
