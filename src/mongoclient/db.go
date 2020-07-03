package mongoclient

import (
	"context"
	"env"
	"errors"
	"log"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

// initialises mongo connection
func Connect() (*mongo.Client, error) {
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
func Disconnect(client *mongo.Client) {
	if err := client.Disconnect(context.Background()); err != nil {
		log.Fatal(err)
	}
}

// insert element into collection
func GetCollection(client *mongo.Client, collectionName Collection) (*mongo.Collection, error) {
	environment := env.MakeEnv()
	dbName, err := environment.LookUp("DB_NAME")
	if err != nil {
		return nil, errors.New("Could not obtain db name fron env")
	}

	collection := client.Database(dbName).Collection(collectionName.String())

	return collection, nil
}
