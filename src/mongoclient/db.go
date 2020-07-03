package mongoclient

import (
	"context"
	"env"
	"errors"
	"log"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var dbClient *mongo.Client

// initialises mongo connection
func ConnectToDB() (*mongo.Client, error) {
	// create ctx
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// get mongo url from env
	environment := env.MakeEnv()
	mongourl, err := environment.LookUp("MONGO_URL")
	if err != nil {
		log.Fatal(err)
		return nil, errors.New("DB Connection failed")
	}

	// init connection
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(mongourl))
	if err != nil {
		log.Fatal(err)
		return nil, errors.New("DB Connection failed")
	}

	return client, nil
}

// disconnects from mongo
func DisconnectFromDB() {
	if err := dbClient.Disconnect(context.Background()); err != nil {
		log.Fatal(err)
	}
}
