#!/bin/bash
# runserver.sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./bin/StoreServer_linux.a
elif [[ "$OSTYPE" == "msys" ]]; then
    ./bin/StoreServer_win.exe
fi