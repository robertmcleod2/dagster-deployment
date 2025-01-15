# Dagster libraries to run both dagster-webserver and the dagster-daemon. Does not
# need to have access to any pipeline code.
FROM python:3.12-slim

COPY . .

# set pip index url
ARG ADO_TOKEN
RUN pip config set global.index-url https://${ADO_TOKEN}@sede-sc.pkgs.visualstudio.com/sepypi/_packaging/DevEnergyForecasting/pypi/simple/

# Checkout and install dagster libraries needed to run the gRPC server
# exposing your repository to dagster-webserver and dagster-daemon, and to load the DagsterInstance
RUN pip install -e .[dev]
RUN pip install \
    dagster \
    dagster-postgres \
    dagster-aws \
    dagster-k8s \
    dagster-celery[flower,redis,kubernetes] \
    dagster-celery-k8s

# install libgomp dependency for lightgbm and git for mlflow
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install curl libgomp1 git