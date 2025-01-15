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
    dagster-k8s \
    dagster-celery[flower,redis,kubernetes] \
    dagster-celery-k8s \
    --system

# install libgomp dependency for lightgbm and git for mlflow
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install curl libgomp1 git