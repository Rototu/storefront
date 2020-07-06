#!/bin/bash
# build.sh

blue=$(tput setaf 4)
normal=$(tput sgr0)

printf "%s\n" "${blue}Compiling F# page...${normal}"
cd frontend/StoreHTML
dotnet publish
cd ../../
printf "%s\n" "${blue}Copying html output to static folder...${normal}"
cp -r frontend/StoreHTML/src/StoreHTML.Client/bin/Debug/netstandard2.1/publish/wwwroot/* static/
printf "%s\n" "${blue}Testing Go Project...${normal}"
cd backend
go test -v ./...
printf "%s\n" "${blue}Building Go Project...${normal}"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    go build -o ../bin/StoreServer_linux.a
elif [[ "$OSTYPE" == "msys" ]]; then
    go build -o ../bin/StoreServer_win.exe
fi