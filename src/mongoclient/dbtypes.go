package mongoclient

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
	name        string
	description string
	price       float64
	ratings     []Rating
	images      []Image
}
