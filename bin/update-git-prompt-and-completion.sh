#!/usr/bin/env bash

BASE_URL="https://raw.githubusercontent.com/git/git/master/contrib/completion/"
BASE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

curl $BASE_URL/git-prompt.sh > $BASE_PATH/git-prompt.sh
curl $BASE_URL/git-completion.bash > $BASE_PATH/git-completion.bash
