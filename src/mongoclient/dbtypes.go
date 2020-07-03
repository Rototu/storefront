package mongoclient

type Collection int

const (
	Items Collection = iota
	Users
	Ratings
)

func (d Collection) String() string {
	return [...]string{"items", "users", "ratings"}[d]
}

type Rating struct {
	id       int
	rating   int
	fullname string
	message  string
	date     string
}

type Image struct {
	filename string
	width    int
	height   int
}

type ShopItem struct {
	id          int
	amount      int
	name        string
	description string
	price       float64
	ratings     []Rating
	images      []Image
}
