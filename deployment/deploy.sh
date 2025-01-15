# retrieve variables from .env file
export $(egrep -v '^#' .env | xargs)

LOCATION=westeurope

# get current date string to use for docker tag
tag=$(date '+%Y%m%d%H%M%S')

# log in to Azure with service principal
az login --service-principal --username ${AZURE_CLIENT_ID} --certificate ${AZURE_CLIENT_CERTIFICATE_PATH} --tenant ${AZURE_TENANT_ID}
az account set --subscription ${AZURE_SUBSCRIPTION_ID}
az config set defaults.group=${AZURE_RESOURCE_GROUP} defaults.location=${LOCATION}

# log in to Azure container registry
az acr login --name ${AZURE_RESOURCE_GROUP}

# build and push docker image
docker build --build-arg ADO_TOKEN=${ADO_TOKEN} -t dagster .
docker image tag dagster ${AZURE_RESOURCE_GROUP}.azurecr.io/dagster:${tag}
docker push ${AZURE_RESOURCE_GROUP}.azurecr.io/dagster:${tag}

# # get container registry admin username and password, used for creating kubernetes secret
username=$(az acr credential show -n ${AZURE_RESOURCE_GROUP} --query username | xargs) 
password=$(az acr credential show -n ${AZURE_RESOURCE_GROUP} --query passwords[0].value | xargs) 

# generate kubernetes values file
export tag=${tag}
export AZURE_RESOURCE_GROUP=${AZURE_RESOURCE_GROUP}
envsubst < values_template.yaml > values_generated.yaml

# deploy to AKS
az aks get-credentials --resource-group ${AZURE_RESOURCE_GROUP} --name ${AZURE_RESOURCE_GROUP}
kubectl config use-context ${AZURE_RESOURCE_GROUP}
kubectl create secret docker-registry mysecret${AZURE_RESOURCE_GROUP} --docker-server ${AZURE_RESOURCE_GROUP}.azurecr.io --docker-username ${username} --docker-password ${password}
helm repo add dagster https://dagster-io.github.io/helm
helm upgrade --install ${AZURE_RESOURCE_GROUP} dagster/dagster -f values_generated.yaml

# view the external IP for the kubernetes ingress
kubectl get service -n app-routing-system