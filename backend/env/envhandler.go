package env

import (
	"errors"
	"log"
	"os"
	"sync"

	"github.com/joho/godotenv"
)

type Environment struct{}

var env Environment

// get environment variable value
func (*Environment) LookUp(varname string) (string, error) {
	envvar, exists := os.LookupEnv(varname)

	if exists {
		return envvar, nil
	}

	return "", errors.New("Environment variable not found")
}

// set os env vars from .env file at root of project
func initEnv() {
	if err := godotenv.Load(); err != nil {
		log.Print("No .env file found")
	}

	env = Environment{}
}

// create and return env
func MakeEnv() *Environment {

	// init os env vars from file
	var once sync.Once
	once.Do(initEnv)

	return &env
}