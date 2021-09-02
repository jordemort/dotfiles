#!/usr/bin/env bash

mcfly=$(type -P mcfly)

if [ -x "$mcfly" ]; then
  eval "$(mcfly init bash)"
fi
