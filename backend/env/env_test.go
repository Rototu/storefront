package env_test

import (
	"testing"

	"github.com/Rototu/StoreFront/env"
)

func TestEnv(t *testing.T) {
	environment, err := env.MakeEnv()

	if err != nil {
		t.Errorf("Error encounterd in reading env file: %s", err)
	}

	t.Run("Getting BACKEND_MONGO_URI from env", func(t *testing.T) {
		_, err := environment.LookUp("BACKEND_MONGO_URI")
		if err != nil {
			t.Errorf("\nError encountered in getting BACKEND_MONGO_URI from env: %s", err.Error())
		}
	})
	t.Run("Getting BACKEND_DB_NAME from env", func(t *testing.T) {
		_, err := environment.LookUp("BACKEND_MONGO_URI")
		if err != nil {
			t.Errorf("\nError encountered in getting BACKEND_DB_NAME collection: %s", err.Error())
		}
	})
}
