#!/bin/bash

swaync-client -swb | while IFS= read -r line; do

  text=$(echo "$line" | jq -r '.text')

  if [[ $((text)) -gt 0 ]]; then
    echo "$line"
  else
    toPut=$(jq -n \
      --arg text "" \
      --arg alt "notification" \
      --arg tooltip "No Notifications" \
      --arg class "notification" \
      '{
    "text": $text,
    "alt": $alt,
    "tooltip": $tooltip,
    "class": $class
    }')

    echo "$toPut" | jq --unbuffered --compact-output
  fi

done
