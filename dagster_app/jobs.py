from dagster import (
    define_asset_job,
)

model_train_predict_job = define_asset_job(
    name="model_train_predict_job",
    selection=["y_train", "x_train", "x_pred", "model_train", "model_predict"]
)