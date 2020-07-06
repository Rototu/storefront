package mongoclient_test

import (
	"testing"

	"github.com/Rototu/StoreFront/mongoclient"
)

func TestDBConnection(t *testing.T) {
	cl, err := mongoclient.Connect()
	if err != nil {
		t.Errorf("Error encounterd in connecting to DB: %s", err)
	}
}
