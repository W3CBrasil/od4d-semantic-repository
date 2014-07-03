#!/usr/bin/env bash

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
	echo "Deploying semantic repository to localhost"
	CONNECTION_STRING=127.0.0.1

	cp $SCRIPT_LOCATION/$PACKAGE_FILE $TEMP_FOLDER
	sh -c "$DEPLOY_CMD"
}

function deploy_to_production {
	if [ "$OD4D_PROD_SERVER" == "" ]; then
		echo "Please set the server address using the environment variable OD4D_PROD_SERVER"
		exit 1
	fi

	echo "Deploying semantic repository to $OD4D_PROD_SERVER"
	CONNECTION_STRING=od4d@$OD4D_PROD_SERVER

	scp $PACKAGE_FILE $CONNECTION_STRING:$TEMP_FOLDER
	ssh $CONNECTION_STRING "$DEPLOY_CMD"
}

if [ ! -f "$SCRIPT_LOCATION/$PACKAGE_FILE" ]; then
	echo "File $PACKAGE_FILE not found."
	echo "Please call this is script from the same directory where the $PACKAGE_FILE is locate."
fi

if [ "$1" == "production" ]; then
	deploy_to_production
else
	deploy_to_localhost
fi
