# Full Stack Online Shop in Go & F\#

## **Work in Progress!**  

This is a simple online shop demo. The back-end is written in GO connected to a MongoDB database. The front-end in written in F# and compiled to WASM with Bolero.

## Setup instructions

Here are the preliminary steps for the project:  

1. Install `dotnet` and `go`.
2. Execute `dotnet new -i Bolero.Templates` in cmd/terminal.  
3. Clone project.  
4. Set project `$GOPATH` to project root directory.
5. Duplicate/rename the `initenv` file to `.env` and manually set the variables in it.

## Building instructions  

### Windows

Run `build.bat` in cmd.  

### Linux

Run `./build.sh` in terminal.  
This method also works for windows machines if the file is run from Git Bash.

## How to run

Note: Make sure to run the executable in cmd / terminal from the project root folder, not from the `bin` folder. Otherwise the executable will not have access to the static folder to serve `index.html`.

### Windows

Run `bin\StoreFront.exe` in cmd to start server.  

### Linux

Run `./bin/StoreServer_lin.a` in terminal to start server.
