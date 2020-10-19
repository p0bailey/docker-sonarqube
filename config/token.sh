#!/bin/bash
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "name=admin" -u admin:admin https://sonar.traefik.me/api/user_tokens/generate\
| jq -r .token > token.txt
