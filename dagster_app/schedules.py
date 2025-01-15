from dagster import ScheduleDefinition

from dagster_app.jobs import model_predict_job, model_train_job

model_train_schedule = ScheduleDefinition(
    job=model_train_job,
    cron_schedule="0 7 * * 1",  # every Monday at 7am
)

model_predict_schedule = ScheduleDefinition(
    job=model_predict_job,
    cron_schedule="0 8 * * *",  # every Tuesday at 8am
)