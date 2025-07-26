package backend

import (
	"io"
	"net/http"
	"time"
)

type RESTBackend struct {
	Client *http.Client
}

func NewRESTBackend() RESTBackend {
	return RESTBackend{
		Client: &http.Client{
			Timeout: 5 * time.Second,
		},
	}
}

func (r RESTBackend) Execute(url string) (any, error) {
	resp, err := r.Client.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, _ := io.ReadAll(resp.Body)
	return string(body), nil
}
