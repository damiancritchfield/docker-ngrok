#!/bin/bash

if [ ! -n "$1" ] ;then
  echo run default:client
  /root/ngrok/start_ngrokd.sh
  return 0
fi

if [ "client" = "$1" ]; then
  echo run client
  /root/ngrok/start_ngrok.sh
fi

if [ "server" = "$1" ]; then
  echo run server
  /root/ngrok/start_ngrokd.sh
fi