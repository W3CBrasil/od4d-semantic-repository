#!/usr/bin/env bash

SERVER=$1

SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PACKAGE_FILE=fuseki-package.tar.gz
TEMP_FOLDER=/tmp

read -d '' DEPLOY_CMD <<EOF
	cd $TEMP_FOLDER
	tar zxvf $PACKAGE_FILE
	cd $TEMP_FOLDER/fuseki-config
	./install.sh
	cd ..
	rm $PACKAGE_FILE && rm -r fuseki-config
EOF

function deploy_to_localhost {
	echo "Deploying semantic repository to localhost..."
	cp $SCRIPT_LOCATION/$PACKAGE_FILE $TEMP_FOLDER
	sh -c "$DEPLOY_CMD"
	echo "Deploy done."
}

function deploy_to_server {
	echo "Deploying semantic repository to $1..."
	CONNECTION_STRING=od4d@$1

	scp $SCRIPT_LOCATION/$PACKAGE_FILE $CONNECTION_STRING:$TEMP_FOLDER
	ssh $CONNECTION_STRING "$DEPLOY_CMD"
	echo "Deploy done."
}

if [ ! -f "$SCRIPT_LOCATION/$PACKAGE_FILE" ]; then
	echo "File $PACKAGE_FILE not found."
	echo "Please call this is script from the same directory where the $PACKAGE_FILE is locate."
fi

if [ "$SERVER" != "localhost" ]; then
	deploy_to_server $SERVER
else
	deploy_to_localhost
fi
