#!/usr/bin/env bash

log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [deemon] - ${1}"
}

while true; do
    if python -m deemon refresh; then
        log "Refresh done."
    fi

    sleep "${DEEMON_PERIOD:-6h}"
done
