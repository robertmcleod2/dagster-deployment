from dagster import (
    define_asset_job,
)

top_stories_job = define_asset_job(
    name="top_stories_job",
    selection=["hackernews_top_story_ids", "hackernews_top_stories"]
)