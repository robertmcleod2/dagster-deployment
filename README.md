# dagster-deployment-practice
A practice dagster deployment using kubernetes

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