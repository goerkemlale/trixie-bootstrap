#!/bin/bash

# Change Working Directory for external sh call
cd "$(dirname "$0")"

ASDFV=$(wget -qO- https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDFV

echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
