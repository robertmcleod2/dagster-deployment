from dagster import Definitions, load_assets_from_modules

from dagster_app import assets, jobs, schedules

all_assets = load_assets_from_modules([assets])

defs = Definitions(
    assets=all_assets,
    jobs=[jobs.top_stories_job],
    schedules=[schedules.top_stories_schedule],
)