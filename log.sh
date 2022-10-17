#!/bin/bash

echo "Creating a log file..."

now=`date +%Y%m%d%H%M%S`
user=`whoami`

echo $user

touch "$user$now.log"

ls -ltr
