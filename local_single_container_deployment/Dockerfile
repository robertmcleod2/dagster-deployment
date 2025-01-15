# Single container deployment useful for local testing. build with:
#  docker build --build-arg ADO_TOKEN=<ado_token> -f local_single_container_deployment/Dockerfile -t dagster .

# Dagster libraries to run both dagster-webserver and the dagster-daemon. Does not
# need to have access to any pipeline code.
FROM python:3.12-slim

COPY . .

# set pip index url
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ARG ADO_TOKEN
ENV UV_INDEX_ADO_PASSWORD=${ADO_TOKEN}

# Checkout and install dagster libraries needed to run the gRPC server
# exposing your repository to dagster-webserver and dagster-daemon, and to load the DagsterInstance
RUN uv pip install -e .[dev] --system
RUN uv pip install \
    dagster \
    dagster-postgres \
    dagster-aws \
    dagster-k8s \
    dagster-celery[flower,redis,kubernetes] \
    dagster-celery-k8s \
    --system

# install libgomp dependency for lightgbm and git for mlflow
# RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
# RUN apt-get -y install curl libgomp1 git

# Set $DAGSTER_HOME and copy dagster instance and workspace YAML there
ENV DAGSTER_HOME=/opt/dagster/dagster_home/

RUN mkdir -p $DAGSTER_HOME

COPY local_single_container_deployment/dagster.yaml $DAGSTER_HOME

WORKDIR /opt/dagster/app

COPY dagster_app/ /opt/dagster/app/dagster_app/

COPY local_single_container_deployment/workspace.yaml /opt/dagster/app/

EXPOSE 3000

# Copy the entrypoint script
COPY local_single_container_deployment/entrypoint.sh /opt/dagster/app/

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]