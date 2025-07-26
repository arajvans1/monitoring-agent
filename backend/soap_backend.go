package backend

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http"
	"time"

	xml2json "github.com/basgys/goxml2json"
)

type SOAPBackend struct {
	URL    string
	Client *http.Client
}

func NewSOAPBackend(url string) *SOAPBackend {
	return &SOAPBackend{
		URL: url,
		Client: &http.Client{
			Timeout: 5 * time.Second,
		},
	}
}

func (s *SOAPBackend) Execute(command string) (any, error) {
	resp, err := s.Client.Post(s.URL, "text/xml", bytes.NewBufferString(command))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	
	jsonBody, err := xml2json.Convert(bytes.NewReader(body))
	if err != nil {
		return nil, err
	}

	var data any
	if err := json.Unmarshal(jsonBody.Bytes(), &data); err != nil {
		return nil, err
	}
	return data, nil
}

