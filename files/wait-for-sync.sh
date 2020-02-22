#!/usr/bin/env bash

until [[ $(curl -s -o /dev/null -w "%{http_code}" localhost:9000/api/v1/status/peer) == "200" ]]; do
	printf 'Syncing DB\n'
    sleep 5
done

echo 'service is available and about to sync'

#EvaluateNetwork
declare -A array
for stateCode in Watch Vote
do
    array[$stateCode]=1
done

until [[ ${array[$(curl -s localhost:9000/api/v1/status/peer | jq -r .state)]} ]]; do
    printf 'Syncing Blocks\n'
    block_height=$(curl -s localhost:9000/api/v1/status/peer | jq -r .block_height)
    echo Blockheight = $block_height
    printf '\n'
    sleep 5
done
