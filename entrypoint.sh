#!/bin/bash

set -eu

if [ -z "$INPUT_PULL_REQUEST_ID" ]; then
  pull_request_id="$(jq "if (.issue.number != null) then .issue.number else .number end" < "$GITHUB_EVENT_PATH")"

  if [ "$pull_request_id" == "null" ]; then
    echo "Could not find the pull request ID. Is this a pull request?"
    exit 0
  fi
else
  pull_request_id="$INPUT_PULL_REQUEST_ID"
fi

/action/autofill_description.py \
  --github-api-url "$GITHUB_API_URL" \
  --github-repository "$GITHUB_REPOSITORY" \
  --pull-request-id "$pull_request_id" \
  --github-token "$INPUT_GITHUB_TOKEN" \
  --openai-api-key "$INPUT_OPENAI_API_KEY" \

