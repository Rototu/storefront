package mongoclient

import (
	"context"

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
	environment, err := env.MakeEnv()
	if err != nil {
		return nil, err
	}
	mongourl, err := environment.LookUp("MONGO_URL")
	if err != nil {
		return nil, err
	}

	// init connection
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(mongourl))
	if err != nil {
		return nil, err
	}

	return client, nil
}

// Disconnect disconnects from mongodb
func Disconnect(client *mongo.Client) error {
	if err := client.Disconnect(context.Background()); err != nil {
		return err
	}

	return nil
}

// GetCollection gets mongodb collection
func GetCollection(client *mongo.Client, collectionName Collection) (*mongo.Collection, error) {
	environment, err := env.MakeEnv()
	if err != nil {
		return nil, err
	}
	dbName, err := environment.LookUp("DB_NAME")
	if err != nil {
		return nil, err
	}

	collection := client.Database(dbName).Collection(collectionName.String())

	return collection, nil
}

func prepareUsersForInsertion(users []*User) []interface{} {
	insertions := make([]interface{}, len(users))
	for _, userPt := range users {
		insertions = append(insertions, *userPt)
	}
	return insertions
}

// InsertUsers inserts user in db
func InsertUsers(userCollection *mongo.Collection, users []*User) (*mongo.InsertManyResult, error) {

	// create temp ctx
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// prepare users for insertion
	insertions := prepareUsersForInsertion(users)

	// insert
	insertResult, err := userCollection.InsertMany(ctx, insertions)

	return insertResult, err
}
