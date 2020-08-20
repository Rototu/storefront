#!/bin/bash
# build.sh

blue=$(tput setaf 4)
normal=$(tput sgr0)

# FRONTEND
printf "%s\n" "${blue}Compiling Elm front-end...${normal}"

cd frontend
./elmbuildscript.sh
cd ../

# BACKEND
printf "%s\n" "${blue}Testing Go Project...${normal}"
cd backend
go test -v ./...
printf "%s\n" "${blue}Building Go Project...${normal}"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    go build -o ../bin/StoreServer_linux.a
elif [[ "$OSTYPE" == "msys" ]]; then
    go build -o ../bin/StoreServer_win.exe
fi
