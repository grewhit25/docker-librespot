#!/bin/bash

arguments=$@

if [ ! -d /tmp/librespot/ ]
then
  mkdir /tmp/librespot/
fi

if [ ! -p /tmp/librespot/fifo ]
then
  mkfifo /tmp/librespot/fifo
fi

#check for secret file account
if [ -f /run/secrets/spotify_account ]
then
  /librespot -n $device_name \
    --username=$(sed -n '/^USER/ s/^USER=\(.*\)/\1/p' /run/secrets/spotify_account) \
    --password=$(sed -n '/^PASSWORD/ s/^PASSWORD=\(.*\)/\1/p' /run/secrets/spotify_account) \
    --device=/tmp/librespot/fifo \
    $arguments
else
  /librespot -n $device_name \
    --username=$user \
    --password=$password \
    --device=/tmp/librespot/fifo \
    $arguments
fi