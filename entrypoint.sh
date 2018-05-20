#!/bin/bash
set -e

cd ./network && make clean all && cd ..
cd ./utils && make clean all && cd ..
cd $1 && make