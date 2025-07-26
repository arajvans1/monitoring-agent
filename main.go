package main

import (
	"log"
	"net/http"
	"time"

	"monitoring-agent/backend"
)


func main() {
	config, err := loadConfig("config/config.yml")
	if err != nil {
		log.Fatalf("failed to load config: %v", err)
	}

	specs, err := loadCommandSpecs(config.CommandSpecPath)
	if err != nil {
		log.Fatalf("failed to load command specs: %v", err)
	}

	backends := map[string]backend.Backend{
		"shell": backend.NewShellBackend(),
		"sql":   backend.NewSQLBackend(config.Database),
		"soap":  backend.NewSOAPBackend(config.SOAPURL),
		"rest":  backend.NewRESTBackend(),
	}

	http.Handle("/execute", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
    switch r.Method {
    case http.MethodPost:
        handleExecute(w, r, specs, backends)
    default:
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
    }
	}))

	log.Println("Server starting on :8080")
	srv := &http.Server{
		Addr:         ":8080",
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
	}
	log.Fatal(srv.ListenAndServe())
}

