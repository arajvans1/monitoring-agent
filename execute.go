package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"html/template"
	"net/http"

	"monitoring-agent/backend"
)

// handleExecute processes the /execute endpoint requests
type CommandRequest struct {
	Name   string            `json:"name"`
	Params map[string]string `json:"params"`
}


func handleExecute(w http.ResponseWriter, r *http.Request, specs map[string]CommandSpec, backends map[string]backend.Backend) {
	req, err := parseRequest(r)
	if err != nil {
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	spec, ok := specs[req.Name]
	if !ok {
		http.Error(w, "unknown command", http.StatusNotFound)
		return
	}
	fmt.Printf("Received command: %s with params: %v\n", req.Name, req.Params)
	fmt.Printf("Request Parameters: %v\n", req.Params) 
	command, err := prepareCommand(spec, req.Params)
	if err != nil {
		http.Error(w, fmt.Sprintf("command error: %v", err), http.StatusBadRequest)
		return
	}

	backend, ok := backends[spec.Backend]
	if !ok {
		http.Error(w, "unknown backend", http.StatusInternalServerError)
		return
	}

	result, err := backend.Execute(command)
	if err != nil {
		http.Error(w, fmt.Sprintf("execution error: %v", err), http.StatusInternalServerError)
		return
	}

	resp := map[string]any{"result": result}
	json.NewEncoder(w).Encode(resp)
}



func parseRequest(r *http.Request) (CommandRequest, error) {
	var req CommandRequest
	err := json.NewDecoder(r.Body).Decode(&req)
	return req, err
}


func prepareCommand(spec CommandSpec, params map[string]string) (string, error) {
	finalParams := map[string]string{}

	// Start with default values
	for k, v := range spec.Params {
		finalParams[k] = v
	}

	// Override with request params
	for k, v := range params {
		finalParams[k] = v
	}

	// Check all required keys
	for _, req := range spec.Required {
		if _, ok := finalParams[req]; !ok {
			return "", errors.New("missing required param: " + req)
		}
	}

	fmt.Printf("Final parameters for command %s: %v\n", spec.Command, finalParams)

// Use Go template for parameter replacement
tmpl, err := template.New("command").Parse(spec.Command)
if err != nil {
		return "", fmt.Errorf("template parse error: %v", err)
}

var buf bytes.Buffer
err = tmpl.Execute(&buf, finalParams)
if err != nil {
		return "", fmt.Errorf("template execution error: %v", err)
}

cmd := buf.String()
fmt.Printf("Command after template execution: %s\n", cmd)

	return cmd, nil
}