package env

import (
	"errors"
	"os"
	"sync"

	"github.com/joho/godotenv"
)

// Environment wrapper for getting env vars
type Environment struct{}

const envPath = "../../.env"

var env Environment

// LookUp get environment variable value
func (*Environment) LookUp(varname string) (string, error) {
	envvar, exists := os.LookupEnv(varname)

	if exists {
		return envvar, nil
	}

	return "", errors.New("Environment variable not found")
}

// set os env vars from .env file at root of project
func initEnv(errChan chan error) {
	if err := godotenv.Load(envPath); err != nil {
		errChan <- err
	}

	env = Environment{}
}

// MakeEnv create and return env
func MakeEnv() (*Environment, error) {

	// init os env vars from file
	var once sync.Once
	var errChan = make(chan error)
	once.Do(func() { initEnv(errChan) })
	err := <-errChan

	return &env, err
}
