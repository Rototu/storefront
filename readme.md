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

To build run `./build.sh` in the Linux terminal or in Git Bash.

## How to run

Run `./runserver.sh` in the Linux terminal or in Git Bash.
