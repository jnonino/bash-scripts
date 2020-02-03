#!/usr/bin/env bash

terraform plan --out=plan_output
terraform show –json plan_output > single_line.json

cat single_line.json | jq . > out.json
rm –rf plan_output single_line.json
