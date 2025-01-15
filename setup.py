from setuptools import find_packages, setup

setup(
    name="dagster_app",
    packages=find_packages(exclude=["dagster_app_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud",
        "pandas",
        # "enerfore",
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)