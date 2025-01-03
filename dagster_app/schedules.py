from dagster import ScheduleDefinition
from dagster_app.jobs import top_stories_job

top_stories_schedule = ScheduleDefinition(
    job=top_stories_job,
    cron_schedule="*/5 * * * *", # every 5 minutes
)