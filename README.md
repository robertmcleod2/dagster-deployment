# dagster-deployment
An example dagster deployment in Azure using a single container

### Local setup

To set up and run the project locally, follow these steps:

1. Clone the repository

```bash
git clone https://github.com/robertmcleod2/dagster-deployment.git
cd dagster-deployment
```

2. create a virtual environment with python version 3.12. For Conda:

```bash
conda create -n dagster-deployment python=3.12
conda activate dagster-deployment
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
docker build -t dagster .
```

2. Run the docker container

```bash
docker run -p 3000:3000 -it dagster
```

The dagster webserver will be available at `http://localhost:3000`

### Future Work

Expand deployment to multiple containers so that the dagster-daemon and dagster-webserver are in separate containers, and user code can be run in a third container, or new containers can be spun up when jobs are run. This will allow for better resource management and scalability. This may be easiest by using Kubernetes.
