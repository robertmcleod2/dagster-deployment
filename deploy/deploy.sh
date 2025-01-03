# build and push docker image
docker build -t dagster-practice .
docker run -p 3000:3000 -it dagster-practice
# docker image tag streamlit ${AZURE_RESOURCE_GROUP}.azurecr.io/dashboard:latest
# docker push ${AZURE_RESOURCE_GROUP}.azurecr.io/dashboard:latest