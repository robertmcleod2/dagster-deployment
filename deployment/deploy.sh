# retrieve variables from .env file
export $(egrep -v '^#' .env | xargs)

LOCATION=westeurope

# log in to Azure with service principal
az login --service-principal --username ${AZURE_CLIENT_ID} --certificate ${AZURE_CLIENT_CERTIFICATE_PATH} --tenant ${AZURE_TENANT_ID}
az account set --subscription ${AZURE_SUBSCRIPTION_ID}
az config set defaults.group=${AZURE_RESOURCE_GROUP} defaults.location=${LOCATION}

# create container registry
az acr login --name ${AZURE_RESOURCE_GROUP}

# get container registry admin username and password, used for creating function app
username=$(az acr credential show -n ${AZURE_RESOURCE_GROUP} --query username | xargs) 
password=$(az acr credential show -n ${AZURE_RESOURCE_GROUP} --query passwords[0].value | xargs) 

kubectl create secret docker-registry my_secret --docker-server ${AZURE_RESOURCE_GROUP} --docker-username ${username} --docker-password ${password}

# docker login azure --client-id ${AZURE_CLIENT_ID} --client-secret ${AZURE_CLIENT_CERTIFICATE_PATH} --tenant-id ${AZURE_TENANT_ID}

# docker context create aci ${AZURE_RESOURCE_GROUP} --resource-group ${AZURE_RESOURCE_GROUP} --location ${LOCATION} --subscription-id ${AZURE_SUBSCRIPTION_ID}

# docker context use ${AZURE_RESOURCE_GROUP}

# az containerapp compose create --resource-group ${AZURE_RESOURCE_GROUP} --environment DagsterDeployment \
#   --compose-file-path docker-compose.yml --registry-username ${username} --registry-password ${password} \
#   --registry-server ${AZURE_RESOURCE_GROUP}.azurecr.io

# # build and push docker images
# docker build -t dagster-webserver . -f Dockerfile.webserver
# docker image tag dagster-webserver ${AZURE_RESOURCE_GROUP}.azurecr.io/webserver:latest
# docker push ${AZURE_RESOURCE_GROUP}.azurecr.io/webserver:latest
# docker build -t dagster-daemon . -f Dockerfile.daemon
# docker image tag dagster-daemon ${AZURE_RESOURCE_GROUP}.azurecr.io/daemon:latest
# docker push ${AZURE_RESOURCE_GROUP}.azurecr.io/daemon:latest
docker build -t dagster .
docker image tag dagster ${AZURE_RESOURCE_GROUP}.azurecr.io/dagster:latest
docker push ${AZURE_RESOURCE_GROUP}.azurecr.io/dagster:latest

# # Check if the container instance already exists
# container_exists=$(az container list --resource-group ${AZURE_RESOURCE_GROUP} --query "[?name=='${AZURE_RESOURCE_GROUP}daemon'].name" -o tsv)

# if [ -z "$container_exists" ]; then
#   # create container instance if it doesn't exist
#   az container create --name ${AZURE_RESOURCE_GROUP}daemon --resource-group ${AZURE_RESOURCE_GROUP} \
#     --image ${AZURE_RESOURCE_GROUP}.azurecr.io/daemon:latest --dns-name-label ${AZURE_RESOURCE_GROUP}daemon --ports 4000 \
#     --registry-username ${username} --registry-password ${password} --os-type Linux --cpu 1 --memory 1.5 --no-wait
# else
#     # restart container instance if it already exists
#     az container restart --name ${AZURE_RESOURCE_GROUP}daemon --resource-group ${AZURE_RESOURCE_GROUP} --no-wait
# fi

# create webserver web app
# az webapp create --name ${AZURE_RESOURCE_GROUP}dagster --plan ${AZURE_RESOURCE_GROUP} --resource-group  ${AZURE_RESOURCE_GROUP} \
#   --container-image-name ${AZURE_RESOURCE_GROUP}.azurecr.io/dagster:latest \
#   --container-registry-user ${username} --container-registry-password ${password} --https-only true

