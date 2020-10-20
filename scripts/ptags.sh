#!/bin/bash

dir=$(dirname $0)
ptags_cmd="${dir}/ptags.py"

find . -name "*.py" | awk '{ printf("%s ", $1);}' | awk -v cmd="${ptags_cmd}" '{printf("%s %s\n", cmd, $0);}' | sh
