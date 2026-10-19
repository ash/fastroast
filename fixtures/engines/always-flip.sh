#!/bin/sh
# Planted BASE defect: the first test always fails, fat or not.
engine="${FASTROAST_ENGINE:-rakupp}"
"$engine" "$@" | sed 's/^ok 1 /not ok 1 /'
