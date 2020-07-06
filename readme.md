# Full Stack Online Shop in Go & F\#

## **Work in Progress!**  

This is a simple online shop demo. The back-end is written in GO connected to a MongoDB database. The front-end in written in F# and compiled to WASM with Bolero.

## Setup instructions

Here are the preliminary steps for the project:  

1. Install `dotnet` and `go`.
2. Execute `dotnet new -i Bolero.Templates` in cmd/terminal.  
3. Clone project under go projects path (the `GOPATH` environment variable points to the appropriate location).  
4. Duplicate/rename the `initenv` file to `.env` and manually set the variables in it:  
    Set `MONGO_URL` to your mongo url (e.g. `mongodb://localhost:27017`).  
    Set `DB_NAME` to the name of the db in which you will host the relevant collections (e.g. `db`).
5. Make sure to have a terminal application that can handle `.sh` files installed (Git Bash recommended).

## Building instructions  

To build run `./build.sh` in the terminal.

## How to run

To start the server run `./runserver.sh` in the terminal.  
Then access `http://localhost:3000/` to view served page.  
