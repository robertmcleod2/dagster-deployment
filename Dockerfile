FROM python:3.10-slim

COPY . .

RUN pip install -e .[dev] \
    && pip install dagster-webserver dagster-postgres dagster-aws

# Copy your code and workspace to /opt/dagster/app
COPY dagster_app/ dagster_app/

# Set the DAGSTER_HOME environment variable to /dagster_home
RUN mkdir -p /dagster_home
ENV DAGSTER_HOME=/dagster_home

# Copy dagster instance YAML to $DAGSTER_HOME
COPY dagster.yaml /dagster_home/

EXPOSE 3000

# ENTRYPOINT ["dagster-webserver", "-h", "0.0.0.0", "-p", "3000"]

ENTRYPOINT ["dagster", "dev", "-h", "0.0.0.0", "-p", "3000"]