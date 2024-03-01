#!/usr/bin/env bash

rootspace=`df / | awk '/[0-9]%/{print $(NF-2)}'`

if [ $rootspace -gt '10000' ]; then
  result=0
else
  result=1
fi

exit $result