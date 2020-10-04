#!/usr/bin/env bash

function wait_for_sync() {
  until [[ $(curl -s -o /dev/null -w "%{http_code}" localhost:9000/api/v1/status/peer) == "200" ]]; do
    printf 'Syncing DB\n'
      sleep 5
  done
  echo 'service is available and about to sync'
}

function sync() {
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
}

function associate_on_own() {
  aws ec2 disassociate-address --public-ip  {{ main_ip }} || true
  aws ec2 associate-address --instance-id {{ this_instance_id }} --public-ip {{ main_ip }}
}

function re_sync() {
  until [[ "$(curl -s http://whatismyip.akamai.com/)" == "{{ main_ip }}" ]]; do
    docker-compose down
    docker-compose up -d
    until [[ ${array[$(curl -s localhost:9000/api/v1/status/peer | jq -r .state)]} ]]; do
      sleep 5
    done
  done
}

REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq .region -r`
export AWS_DEFAULT_REGION=$REGION

wait_for_sync && \
sync {% if switch_ip_internally %}&& \
associate_on_own{% endif %} && \
re_sync
