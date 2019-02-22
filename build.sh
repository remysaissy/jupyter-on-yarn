#!/bin/sh

ENVS_PREFIX=$HOME/jupyter-yarn-envs
TEMPLATE_DIR=base
REQS_TEMPLATE=$(pwd)/$TEMPLATE_DIR/requirements.txt
DESCRIPTOR_TEMPLATE=$(pwd)/$TEMPLATE_DIR/descriptor.yml
JUPYTER_CONFIG_FILE=$(pwd)/$TEMPLATE_DIR/jupyter_notebook_config.py
VENV_PACK_NAME=jupyter-yarn.tar.gz
ENV_NAME=${1:-default}
DESCRIPTOR_FILE=$ENV_NAME.yml

echo "Creating $ENV_NAME virtualenv..."
rm -rf $ENVS_PREFIX/$ENV_NAME
mkdir -p $ENVS_PREFIX/$ENV_NAME
python3.6 -m venv $ENVS_PREFIX/$ENV_NAME/.$ENV_NAME
source $ENVS_PREFIX/$ENV_NAME/.$ENV_NAME/bin/activate
pip install -r $REQS_TEMPLATE
mkdir -p $ENVS_PREFIX/$ENV_NAME/.$ENV_NAME/etc/jupyter
cp $JUPYTER_CONFIG_FILE $ENVS_PREFIX/$ENV_NAME/.$ENV_NAME/etc/jupyter/
# Environment packaging.
pip install venv-pack
venv-pack -o $ENVS_PREFIX/$ENV_NAME/$VENV_PACK_NAME
python passwd.py
deactivate

echo "Creating the deployment file descriptor $DESCRIPTOR_FILE..."
sed 's@^name:.*@'"name: $ENV_NAME"'@' $DESCRIPTOR_TEMPLATE > $ENVS_PREFIX/$ENV_NAME/$DESCRIPTOR_FILE


echo "Done. You can use deploy.sh."
