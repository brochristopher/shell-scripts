#!/bin/bash

# Put the path to your file containing all of the mimir endpoints here
filename=""

# This should look like https://prometheus-prod-10-prod-us-central-0.grafana.net/api/prom"
prom_url=""

# This is your user ID or tenant ID for the hosted prometheus endpoint
readonly USER=

# This should be a Cloud API key or Cloud Access Policy token, also known as a gcom API key
readonly API_KEY=""

# LEAVE THIS EMPTY. Putting a value here will break the non-verbose functionality of the script.
verbose=''

# Guard clauses
if [[ $# -ge 2 ]]; then
        echo "You have passed too many arguments. Please either provide no argument, or provide the optional --verbose or -v flag."
        exit 123
fi

if [[ $# == 1 ]]; then
    if [[ ${1} == "-v" || ${1} == "--verbose" ]]; then
            verbose='_verbose'
    else
            echo "You have passed an invalid argument. The only flag available is the optional --verbose or -v flag."
            exit 234
    fi
fi 

# Function definitions
probe_mimir_api() {
        echo -e "HTTP Status Code: $(curl -s -o /dev/null -w "%{http_code}" -u "${USER}:${API_KEY}" "${prom_url}${api}")"
}

probe_mimir_api_verbose() {
        curl -s -u "${USER}:${API_KEY}" "${prom_url}${api}"
}

# Main
echo -e "An http status code of 200 is a success, 400 is a real endpoint with an invalid payload, and a 404 is an endpoint which does not exist.\n"

while IFS= read -r api; do
        echo "Testing ${api}..."
        sleep 1

        # Calling either probe_mimir_api or probe_mimir_api_verbose based on whether the -v flag was provided.
        "probe_mimir_api$verbose"

        echo -e "\n"
        sleep 1
done < "$filename"
