#!/bin/bash
# runserver.sh

blue=$(tput setaf 4)
normal=$(tput sgr0)

printf "%s\n" "${blue}Starting go server in separate window...${normal}"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    start sh -c "./bin/StoreServer_linux.a"
elif [[ "$OSTYPE" == "msys" ]]; then
    start sh -c "./bin/StoreServer_win.exe"
fi

printf "%s\n" "${blue}Serving front-end in separate window...${normal}"

./frontend/serve.sh
