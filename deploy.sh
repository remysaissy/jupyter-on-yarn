#!/bin/sh

ENVS_PREFIX=$HOME/jupyter-yarn-envs
TEMPLATE_DIR=base
REQS_TEMPLATE=$(pwd)/$TEMPLATE_DIR/requirements.txt
DESCRIPTOR_TEMPLATE=$(pwd)/$TEMPLATE_DIR/descriptor.yml
ENV_NAME=${1:-default}
DESCRIPTOR_FILE=$ENV_NAME.yml

echo "Deploying $ENV..."
source $ENVS_PREFIX/$ENV_NAME/.$ENV_NAME/bin/activate

export APPID=$(skein application submit $ENVS_PREFIX/$ENV_NAME/$DESCRIPTOR_FILE)
skein kv get $APPID --key jupyter.notebook.info --wait > /tmp/$ENV_NAME.json
./get_url.py /tmp/$ENV_NAME.json
