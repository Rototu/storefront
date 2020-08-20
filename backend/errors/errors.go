package errors

type errorString struct {
	s string
}

func (e *errorString) Error() string {
	return e.s
}

// New creates simple custom error
func New(text string) error {
	return &errorString{text}
}
