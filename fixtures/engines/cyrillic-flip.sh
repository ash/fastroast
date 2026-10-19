#!/bin/sh
# Planted fat defect: the first test fails whenever the program contains a
# Cyrillic capital А (as a fattened "ABC" does). Wraps a real engine
# (FASTROAST_ENGINE, default rakupp), so everything else is genuine.
engine="${FASTROAST_ENGINE:-rakupp}"
if grep -q 'А' "$1"; then
    "$engine" "$@" | sed 's/^ok 1 /not ok 1 /'
else
    exec "$engine" "$@"
fi
