#installs kfctl

export OPSYS=linux
curl -s https://api.github.com/repos/kubeflow/kubeflow/releases/latest | grep browser_download | grep $OPSYS | cut -d '"' -f 4 | xargs curl -O -L &&  tar -zvxf kfctl_*_${OPSYS}.tar.gz
export PATH=$PATH:$PWD




# Set your GCP project ID and the zone where you want to create 
# the Kubeflow deployment:
export PROJECT=hadoop-project-262610
gcloud config set project ${PROJECT}
export ZONE=europe-west-1-d
gcloud config set compute/zone ${ZONE}

# Use the following kfctl configuration file for authentication with 
# Cloud IAP (recommended):
#export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v0.7-branch/kfdef/kfctl_gcp_iap.0.7.1.yaml"

# If using Cloud IAP for authentication, create environment variables
# from the OAuth client ID and secret that you obtained earlier:
#export CLIENT_ID=<CLIENT_ID from OAuth page>
#export CLIENT_SECRET=<CLIENT_SECRET from OAuth page>

# Alternatively, use the following kfctl configuration if you want to use 
# basic authentication:
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v0.7-branch/kfdef/kfctl_gcp_basic_auth.0.7.1.yaml"

# If using basic authentication, create environment variables
# for username and password:
export KUBEFLOW_USERNAME=antoine
export KUBEFLOW_PASSWORD=alexis

# Set KF_NAME to the name of your Kubeflow deployment. You also use this
# value as directory name when creating your configuration directory. 
# See the detailed description in the text below this code snippet.
# For example, your deployment name can be 'my-kubeflow' or 'kf-test'.
export KF_NAME=kf-hadoop

# Set the path to the base directory where you want to store one or more 
# Kubeflow deployments. For example, /opt/.
# Then set the Kubeflow application directory for this deployment.
export BASE_DIR=/kubeflow
export KF_DIR=${BASE_DIR}/${KF_NAME}

# The following command is optional. It adds the kfctl binary to your path.
# If you don't add kfctl to your path, you must use the full path
# each time you run kfctl.
export PATH=$PATH:$PWD



sudo mkdir -p ${KF_DIR}
cd ${KF_DIR}
kfctl apply -V -f ${CONFIG_URI}