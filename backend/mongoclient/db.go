package mongoclient

import (
	"context"
	"errors"
	"log"

	"github.com/Rototu/StoreFront/env"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

// Connect initialises mongosb connection
func Connect() (*mongo.Client, error) {
	// create ctx
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// get mongo url from env
	environment := env.MakeEnv()
	mongourl, err := environment.LookUp("MONGO_URL")
	if err != nil {
		log.Fatal(err)
		return nil, errors.New("Missing DB env vars")
	}

	// init connection
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(mongourl))
	if err != nil {
		log.Fatal(err)
		return nil, errors.New("DB Connection failed")
	}

	log.Println("Connected to DB")

	return client, nil
}

// Disconnect disconnects from mongodb
func Disconnect(client *mongo.Client) {
	if err := client.Disconnect(context.Background()); err != nil {
		log.Fatal(err)
	}
}

// GetCollection gets mongodb collection
func GetCollection(client *mongo.Client, collectionName Collection) (*mongo.Collection, error) {
	environment := env.MakeEnv()
	dbName, err := environment.LookUp("DB_NAME")
	if err != nil {
		return nil, errors.New("Could not obtain db name fron env")
	}

	collection := client.Database(dbName).Collection(collectionName.String())

	return collection, nil
}
