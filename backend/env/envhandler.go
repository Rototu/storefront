package env

import (
	"errors"
	"os"
	"sync"

	"github.com/joho/godotenv"
)

// Environment wrapper for getting env vars
type Environment struct{}

const testsEnvPath = "../.env"

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
func initEnv() error {
	if err := godotenv.Load(); err != nil {
		if err = godotenv.Load(testsEnvPath); err != nil {
			return err
		}
	}

	env = Environment{}
	return nil
}

// MakeEnv create and return env
func MakeEnv() (*Environment, error) {

	// init os env vars from file
	var once sync.Once
	var err error = nil
	once.Do(func() { err = initEnv() })

	return &env, err
}
