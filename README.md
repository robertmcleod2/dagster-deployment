# dagster-kubernetes-deployment
An example dagster deployment in Azure using kubernetes

### Local setup

To set up and run the project locally, follow these steps:

1. Clone the repository

```bash
git clone https://github.com/robertmcleod2/dagster-deployment-practice.git
cd dagster-deployment-practice
```

2. create a virtual environment with python version 3.12. For Conda:

```bash
conda create -n dagster-deployment-practice python=3.12
conda activate dagster-deployment-practice
```

3. Install the required packages

```bash
pip install -e ".[dev]"
```

4. Set up your local environment variables. Create a `.env` file in the root directory of the project, following the template in the .env_template file


5. start the Dagster webserver:

```bash
dagster dev
```

The dagster webserver will be available at `http://localhost:3000`

### Run from docker container

To run the project from a docker container, follow step 1 above then these steps:

1. Build the docker images

```bash
docker build -t dagster-webserver . -f Dockerfile.webserver
docker build -t dagster-daemon . -f Dockerfile.daemon
```

2. Run the docker container

```bash
docker run -p 3000:3000 -it dagster-webserver
docker run -p 4000:4000 -it dagster-daemon
```

The dagster webserver will be available at `http://localhost:3000`
