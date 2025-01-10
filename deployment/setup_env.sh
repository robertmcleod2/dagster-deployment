# retrieve variables from .env file
export $(egrep -v '^#' .env | xargs)

LOCATION=westeurope

# log in to Azure with service principal
az login --service-principal --username ${AZURE_CLIENT_ID} --certificate ${AZURE_CLIENT_CERTIFICATE_PATH} --tenant ${AZURE_TENANT_ID}
az account set --subscription ${AZURE_SUBSCRIPTION_ID}
az config set defaults.group=${AZURE_RESOURCE_GROUP} defaults.location=${LOCATION}

# create resource group
az group create -n ${AZURE_RESOURCE_GROUP}

# create container registry
az acr create --name ${AZURE_RESOURCE_GROUP} --sku Standard --admin-enabled true

# create AKS kubernetes cluster
az aks create --resource-group ${AZURE_RESOURCE_GROUP} --name ${AZURE_RESOURCE_GROUP} --tier free --dns-name-prefix ${AZURE_RESOURCE_GROUP} --generate-ssh-keys --enable-app-routing
