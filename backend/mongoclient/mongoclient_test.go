package mongoclient_test

import (
	"testing"

	"github.com/Rototu/StoreFront/mongoclient"
)

func TestDB(t *testing.T) {
	cl, err := mongoclient.Connect()
	if err != nil {
		t.Errorf("Error encounterd in connecting to DB: %s", err)
	}
	t.Run("Getting \"Items\" collection", func(t *testing.T) {
		_, err := mongoclient.GetCollection(cl, mongoclient.Items)
		if err != nil {
			t.Errorf("\nError encountered in getting %s collection: %s", mongoclient.Items, err.Error())
		}
	})
	t.Run("Getting \"Users\" collection", func(t *testing.T) {
		_, err := mongoclient.GetCollection(cl, mongoclient.Ratings)
		if err != nil {
			t.Errorf("\nError encountered in getting %s collection: %s", mongoclient.Ratings, err.Error())
		}
	})
	t.Run("Getting \"Ratings\" collection", func(t *testing.T) {
		_, err := mongoclient.GetCollection(cl, mongoclient.Users)
		if err != nil {
			t.Errorf("\nError encountered in getting %s collection: %s", mongoclient.Users, err.Error())
		}
	})
}
