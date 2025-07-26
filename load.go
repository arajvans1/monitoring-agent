package main

import (
	"fmt"
	"html/template"
	"os"

	"gopkg.in/yaml.v2"
)


type CommandSpec struct {
	Command  string            `yaml:"command"`
	Backend  string            `yaml:"backend"`
	Params   map[string]string `yaml:"params"`
	Required []string          `yaml:"required"`
}

type Config struct {
	CommandSpecPath string `yaml:"commandSpecPath"`
	SOAPURL         string `yaml:"soapUrl"`
	Database        string `yaml:"database"`
}

func loadConfig(path string) (Config, error) {
	var cfg Config
	data, err := os.ReadFile(path)
	if err != nil {
		return cfg, err
	}
	err = yaml.Unmarshal(data, &cfg)
	return cfg, err
}


func loadCommandSpecs(path string) (map[string]CommandSpec, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	specs := make(map[string]CommandSpec)
	if err := yaml.Unmarshal(data, &specs); err != nil {
		return nil, err
	}

	for name, spec := range specs {
		if _, err := template.New("cmd").Parse(spec.Command); err != nil {
			return nil, fmt.Errorf("template parse error in command %s: %v", name, err)
		}
		for _, param := range spec.Required {
			if _, ok := spec.Params[param]; !ok {
				return nil, fmt.Errorf("missing default for required param %s in command %s", param, name)
			}
		}
		
	}
	return specs, nil
}