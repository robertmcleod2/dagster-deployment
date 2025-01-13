# dagster-kubernetes-deployment
An example dagster deployment in Azure using kubernetes. The project is a simple example of how to deploy a dagster pipeline to a kubernetes cluster in Azure. The kubernetes cluster is deployed in a CI/CD pipeline to Azure using a Helm chart.

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

### Future Work

- Add a DNS name to the Kubernetes cluster
- Add an example forecasting model to the dagster pipeline
