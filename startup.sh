#!/bin/sh
yarn webpack > ./webpack.log 2>&1 &
yarn start > ./bucklescript.log 2>&1 
