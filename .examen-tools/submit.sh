#!/bin/bash

#
# e_push commits and pushes all current changes using the first argument as
# commit message.
#
# Argument 1: commit message
#
e_push () {
    git add -A
    git commit -m "$1"
    # push the current branch to origin
    git push -u origin HEAD
    if [[ "$?" == 0 ]]; then
        return 0
    fi
    echo -e "\e[31mERROR: Indienen faalde!\e[0m"
    return 1
}


#
# e_periodic_push commits and pushes all changes every X seconds with a 
# timestamp as commit message.
#
# Argument 1: interval between commits
#
e_periodic_push () {
    git config credential.helper store
    while true; do
        timestamp=$(date)
        echo "PUSHING CODE at $timestamp"
        success="false"
        while [[ "$success" != "true" ]]; do
            e_push "$timestamp"
            if [[ "$?" == 0 ]]; then
                success="true"
            else
                echo -e "\e[31mWe proberen opnieuw over 1 seconde.\e[0m"
                sleep 1
            fi
        done
        echo "FINISHED PUSHING CODE"
        echo "WAITING $1 seconds"
        echo ""
        echo ""
        echo ""
        sleep $1
    done
}


if [[ "$1" == "manual" ]]; then
    echo "MANUAL PUSH"
    e_push "Manual commit on $(date)"
else
    e_periodic_push 600
fi