from dagster import ScheduleDefinition

from dagster_app.jobs import model_train_predict_job

model_train_predict_schedule = ScheduleDefinition(
    job=model_train_predict_job,
    cron_schedule="0 8 * * *",  # Run every day at 8:00 UTC
)
