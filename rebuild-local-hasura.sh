#!/bin/bash

# Define the URL to call
url="http://localhost:8080/v1/version"

# Define a variable to store the start time
start_time=$(date +%s)

# Define a variable to store the HTTP status code of the response
http_status=0

# Define a timeout in seconds (2 minutes)
timeout=120


# ------------------------------------------------------------------------
# ------------------------ Pre-checks ready ------------------------------
# ------------------------------------------------------------------------


echo "Deleting previous containers and volumes."
docker rm -f hasura_local
docker rm -f hasura_db_local
docker volume rm hasura-permissions_dbbackups
docker volume rm hasura-permissions_postgis-data
echo "All clean."

sleep 1

echo "Creating new containers and volumes"
docker compose up -d


# Define a loop that runs until a successful response (HTTP status code 200) is received or a timeout occurs
echo "Waiting for hasura container to be live:"
while [ $http_status -ne 200 ]; do
    # Get the current time
    current_time=$(date +%s)

    # Calculate the elapsed time
    elapsed_time=$((current_time - start_time))

    # Check if the timeout has been reached
    if [ $elapsed_time -ge $timeout ]; then
        echo "Timeout reached. Service did not return a successful response within 2 minutes."
        exit 1
    fi

    # Call the URL using curl and store the HTTP status code in http_status
    http_status=$(curl -s -o /dev/null -w "%{http_code}" $url)

    # Check if the HTTP status code is not 200 (success)
    if [ $http_status -ne 200 ]; then
        echo "Service returned HTTP status code $http_status. Retrying in 1 second..."
        sleep 1
    fi
done
echo "Service running correctly."

sleep 1

echo "Applying Hasura Migrations from ./migrations"
npx hasura migrate apply --database-name default --skip-update-check

echo "Applying Hasura Metadata from ../metadata"
npx hasura metadata apply --skip-update-check

echo "Applying Hasura Seeds from ./seeds"
npx hasura seed apply --database-name default
