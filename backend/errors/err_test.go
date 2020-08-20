package errors_test

import (
	"errors"
	"testing"
)

func TestErr(t *testing.T) {

	customErrorMessage := "CUSTOM ERROR MESSAGE"

	t.Run("Creating custom simple error", func(t *testing.T) {
		err := errors.New("")
		if err == nil {
			t.Errorf("\nCould not create error.")
		}
	})
	t.Run("Testing custom error message", func(t *testing.T) {
		err := errors.New(customErrorMessage)
		if err == nil {
			t.Errorf("\nCould not create a custom error.")
		}
		if err.Error() != customErrorMessage {
			t.Errorf("\nCustom error message mismatch.")
		}
	})
}
