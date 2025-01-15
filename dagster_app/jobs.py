from dagster import (
    define_asset_job,
)

model_train_job = define_asset_job(
    name="model_train_job",
    selection=["y_train", "x_train", "model_train"]
)

model_predict_job = define_asset_job(
    name="model_predict_job",
    selection=["x_pred", "model_predict"]
)