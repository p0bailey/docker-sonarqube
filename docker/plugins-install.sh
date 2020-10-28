#!/bin/bash

cd ${SONARQUBE_HOME}/extensions/plugins/

input="plugins-list.txt"
while IFS= read -r line
do
  wget   $line 
done < "$input"
