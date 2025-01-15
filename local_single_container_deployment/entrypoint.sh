#!/bin/sh

# Start the dagster-webserver
dagster-webserver -h 0.0.0.0 -p 3000 &

# Start the dagster-daemon
dagster-daemon run