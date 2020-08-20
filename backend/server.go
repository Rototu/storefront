package main

import (
	"log"
	"net/http"

	"github.com/Rototu/StoreFront/mongoclient"
)

func main() {

	fs := http.FileServer(http.Dir("./static"))
	http.Handle("/", fs)

	mongoclient.Connect()

	log.Println("Listening on :3000...")
	err := http.ListenAndServe(":3000", nil)
	if err != nil {
		log.Fatal(err)
	}
}
