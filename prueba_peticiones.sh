#!/bin/bash

for i in {1..20}; do
curl -w "\n" http://147.156.86.23/index.html
sleep 0.2
done
