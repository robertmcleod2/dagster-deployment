from dagster import Definitions, load_assets_from_modules

from dagster_app import assets, jobs, schedules

all_assets = load_assets_from_modules([assets])

defs = Definitions(
    assets=all_assets,
    jobs=[jobs.model_train_job, jobs.model_predict_job],
    schedules=[schedules.model_train_schedule, schedules.model_predict_schedule],
)