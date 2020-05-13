#!/bin/bash

workdir=$(cd $(dirname $0); pwd)
cd $workdir

./ngrok -config=ngrok.cfg start-all