#!/usr/bin/env bash

gpgconf --launch gpg-agent
export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
