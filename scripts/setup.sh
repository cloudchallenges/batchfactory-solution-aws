#!/bin/bash

/usr/local/bin/mise trust /workspaces/solution-template/mise.toml && /usr/local/bin/mise install
sudo apt update && sudo apt install -y tmux python3
