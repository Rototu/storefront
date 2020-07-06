package mongoclient

// Collection enum type for db collections
type Collection int

// Exported collection enum values
const (
	Items Collection = iota
	Users
	Ratings
)

func (d Collection) String() string {
	return [...]string{"items", "users", "ratings"}[d]
}

// Rating structure for rating items in db
type Rating struct {
	id       int
	rating   int
	fullname string
	message  string
	date     string
}

// Image structure for image items in db
type Image struct {
	filename string
	width    int
	height   int
}

// ShopItem structure for shop product items in db
type ShopItem struct {
	id          int
	amount      int
	name        string
	description string
	price       float64
	ratings     []Rating
	images      []Image
}

// User structure for users in db
type User struct {
	id           int
	userName     string
	email        string
	passwordhash int64
}
